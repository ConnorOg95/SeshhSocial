//
//  HomeScreenVC.swift
//  SeshhSocial
//
//  Created by User on 17/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CONNOR: ID removed from keychain \(keychainResult)")
        performSegue(withIdentifier: "goToLogIn", sender: nil)
    }


}
