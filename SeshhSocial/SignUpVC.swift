//
//  SignUpVC.swift
//  SeshhSocial
//
//  Created by User on 13/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    

    @IBOutlet weak var usernameTxtFld: ModifiedTextField!
    @IBOutlet weak var passwordTxtFld: ModifiedTextField!
    @IBOutlet weak var confirmedPasswordTxtFld: ModifiedTextField!
    @IBOutlet weak var emailTxtFld: ModifiedTextField!
    @IBOutlet weak var confirmedEmailTxtFld: ModifiedTextField!
    @IBOutlet weak var firstNameTxtFld: ModifiedTextField!
    @IBOutlet weak var lastNameTxtFld: ModifiedTextField!
    //NEEDS TO BE A DATE
    @IBOutlet weak var DOBBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var informationLbl: UILabel!
    @IBOutlet weak var usernameUnderline: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUp() {
        guard let username = usernameTxtFld.text, username != "" else {
            // HIGHLIGHT TO USER
            self.usernameUnderline.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 1.0)
            print("CONNOR: Username signup error")
            return
        }
        guard let email = confirmedEmailTxtFld.text, email != "" else {
            // HIGHLIGHT TO USER
            print("CONNOR: Confirmed email signup error")
            return
        }
        guard let password = confirmedPasswordTxtFld.text, password != "" else {
            // HIGHLIGHT TO USER
            print("CONNOR: Confirmed password signup error")
            return
        }
        guard let firstName = firstNameTxtFld.text, firstName != "" else {
            // HIGHLIGHT TO USER
            print("CONNOR: Confirmed first name signup error")
            return
        }
        guard let lastName = lastNameTxtFld.text, lastName != "" else {
            // HIGHLIGHT TO USER
            print("CONNOR: Confirmed last name signup error")
            return
        }
        guard let DOB = DOBBtn.titleLabel?.text, DOB != "" else {
            // HIGHLIGHT TO USER
            print("CONNOR: Confirmed DOB signup error")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("CONNOR: Failed to create user \(error)!")
                return
            } else {
                print("CONNOR: Succesfully created user.")
                if let user = user {
                let userData = ["provider": user.providerID, "username": username, "firstName": firstName, "lastName": lastName, "email": email, "DOB": DOB]
                self.completeSignUp(id: user.uid, userData: userData)
                }
                self.dismiss(animated: true, completion: nil)
            }
//            guard let uid = user?.uid else {
//                return
//            }
//            let userReference = self.databaseRef.child("users").child(uid)
//            let values = ["username": username, "email": confirmedEmail, "password": confirmedPassword]
//            userReference.updateChildValues(values
//                , withCompletionBlock: { (error, ref) in
//                    if error != nil {
//                        print(error!)
//                        return
//                    }
//                    self.dismiss(animated: true, completion: nil)
//            })
        })
    }
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        if (passwordTxtFld.text != confirmedPasswordTxtFld.text) {
            print("CONNOR: Passwords do not match")
            // POP UP FOR PASSWORDS NOT MATCHING
        } else if (emailTxtFld.text != confirmedEmailTxtFld.text) {
            print("CONNOR: Emails do not match")
            // POP UP FOR EMAILS NOT MATCHING
        } else {
        signUp()
        }
    }
    
    func completeSignUp(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
    }
    
    @IBAction func DOBBtnPressed(_ sender: Any) {
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.isHidden = false
        signUpBtn.isHidden = true
        informationLbl.isHidden = true
    }
    
    func dateFormat() {
        
//        datePicker.datePickerMode = UIDatePickerMode.date
        
        let dateFormatter = DateFormatter()
        let short = DateFormatter.Style.short
        dateFormatter.dateStyle = short
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let strDate = dateFormatter.string(from: datePicker.date)
        DOBBtn.titleLabel!.text = strDate
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        
//        self.DOBBtn.titleLabel?.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dateFormat()
        datePicker.isHidden = true
        signUpBtn.isHidden = false
    }
    
    
}


//    @IBAction func signUpBtnPressed(_ sender: Any) {
//        }
//        
//        if let email = confirmedEmailTxtFld.text, let password = confirmedPasswordTxtFld.text {
//            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
//                if error != nil {
//                    //POP UP MESSAGE
//                    print("CONNOR: Unable to authenticate with Firebase Email")
//                } else {
//                    print("CONNOR: Sucessfully authenticated with Firebase Email")
//            
//                }
//            })
//        }
//    }
//}
