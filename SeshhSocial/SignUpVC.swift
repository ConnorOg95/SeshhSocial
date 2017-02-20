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
    
//    let databaseRef = FIRDatabase.database().reference(fromURL: "https://seshh-social.firebaseio.com/")

    @IBOutlet weak var usernameTxtFld: ModifiedTextField!
    @IBOutlet weak var passwordTxtFld: ModifiedTextField!
    @IBOutlet weak var confirmedPasswordTxtFld: ModifiedTextField!
    @IBOutlet weak var emailTxtFld: ModifiedTextField!
    @IBOutlet weak var confirmedEmailTxtFld: ModifiedTextField!
    @IBOutlet weak var firstNameTxtFld: ModifiedTextField!
    @IBOutlet weak var lastNameTxtFld: ModifiedTextField!
    @IBOutlet weak var DOBTxtFld: ModifiedTextField!
    @IBOutlet weak var descriptionTxtFld: ModifiedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUp() {
        guard let username = usernameTxtFld.text else {
            print("CONNOR: Username signup error")
            return
        }
        guard let confirmedEmail = confirmedEmailTxtFld.text else {
            print("CONNOR: Confirmed email signup error")
            return
        }
        guard let confirmedPassword = confirmedPasswordTxtFld.text else {
            print("CONNOR: Confirmed password signup error")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: confirmedEmail, password: confirmedPassword, completion: { (user, error) in
            if error != nil {
                print("CONNOR: Failed to create user \(error)!")
                return
            } else {
                print("CONNOR: Succesfully created user.")
                if let user = user {
                let userData = ["provider": user.providerID, "username": username]
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
        
        //Check if any of the fields are empty - Needs to be added
        
        if (passwordTxtFld.text != confirmedPasswordTxtFld.text) {
            print("CONNOR: Emails do not match")
            // POP UP FOR PASSWORDS NOT MATCHING
        } else if (emailTxtFld.text != confirmedEmailTxtFld.text) {
            print("CONNOR: Passwords do not match")
            // POP UP FOR EMAILS NOT MATCHING
        } else {
        signUp()
        }
    }
    
    func completeSignUp(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
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
