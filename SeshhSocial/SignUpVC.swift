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
    @IBOutlet weak var confirmedPasswordTxtFld: ModifiedTextField!
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
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
        if let email = confirmedEmailTxtFld.text, let password = confirmedPasswordTxtFld.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    //POP UP MESSAGE
                    print("CONNOR: Unable to authenticate with Firebase Email")
                } else {
                    print("CONNOR: Sucessfully authenticated with Firebase Email")
            
                }
            })
        }
    }
}
