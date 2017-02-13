//
//  SignInVC.swift
//  SeshhSocial
//
//  Created by User on 13/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTxt: ModifiedTextField!
    @IBOutlet weak var passwordTxt: ModifiedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func firebaseAuth(_ credential: FIRAuthCredential) {
//        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
//            if error != nil {
//                print("CONNOR: Unable to authenticate with Firebase - \(error)")
//            } else {
//                print("CONNOR: Successfully authenticated with Firebase")
//            }
//        })
//    }

    @IBAction func logInBtnPressed(_ sender: Any) {
        
        if let email = emailTxt.text, let password = passwordTxt.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("CONNOR: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("CONNOR: Unable to authenticate with Firebase Email")
                        } else {
                            print("CONNOR: Sucessfully authenticated with Firebase Email")
                        }
                    })
                }
            })
        }
    }

}

