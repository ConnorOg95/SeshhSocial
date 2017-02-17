//
//  SignInVC.swift
//  SeshhSocial
//
//  Created by User on 13/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTxt: ModifiedTextField!
    @IBOutlet weak var passwordTxt: ModifiedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToHomePage", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //THIS IS FIREBASE AUTHENTICATION USED FOR FB/GOOGLE LOGIN
//    func firebaseAuth(_ credential: FIRAuthCredential) {
//        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
//            if error != nil {
//                print("CONNOR: Unable to authenticate with Firebase - \(error)")
//            } else {
//                print("CONNOR: Successfully authenticated with Firebase")
//                if let user = user {
//                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
//                }
//            }
//        })
//    }

    @IBAction func logInBtnPressed(_ sender: Any) {
        
        if let email = emailTxt.text, let password = passwordTxt.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil {
                    
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        
                        switch errCode {
                        case .errorCodeInvalidEmail:
                            let alert1 = UIAlertController(title: "Yeah nah nah nah yeah..", message:"The email you have entered is a incorrect format.", preferredStyle: .alert)
                            alert1.addAction(UIAlertAction(title: "No Drama", style: .default) { _ in })
                            self.present(alert1, animated: true){}
                            print("CONNOR: Invalid email")
                        case .errorCodeWrongPassword:
                            let alert1 = UIAlertController(title: "Yeah nah nah nah yeah..", message:"The password you have entered is incorrect for this email address.", preferredStyle: .alert)
                            alert1.addAction(UIAlertAction(title: "No Drama", style: .default) { _ in })
                            self.present(alert1, animated: true){}
                            print("CONNOR: Incorrect password")
                        default:
                            print("CONNOR: Create User Error: \(error!)")
                        }
                    }
                } else {
                    print("CONNOR: Log In Authentication Successful")
                    if let user = user {
                        KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                        self.performSegue(withIdentifier: "goToHomePage", sender: nil)
                    }
                }
            })
        }
    }
    
    
    
    
    
}


//                if error == nil {
//                    print("CONNOR: Email user authenticated with Firebase")
//                } else {
//                    if let error = error {
//                        switch FIRAuthErrorCode(rawValue: error.code) !{
//                                case .ErrorCodeInvalidEmail:
//                                print("CONNOR: Invalid Email")
//                                default:
//                                print("CONNOR: Default Error")
//                        }
//                    }
//                    let loginAlert = UIAlertController (title: "Warning!", message: "You have provided an incorrect username or password. Please try again.", preferredStyle: .alert)
//                    self.present(loginAlert, animated: true, completion: nil)
//                    let okAction = UIAlertAction (title: "Ok", style: .default) { (action: UIAlertAction) in }
//                    loginAlert.addAction(okAction)
////
//                    print("CONNOR: Unable to authenticate Email with Firebase")

