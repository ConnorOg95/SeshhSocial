//
//  DataService.swift
//  SeshhSocial
//
//  Created by User on 19/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_SESHHS = DB_BASE.child("seshhs")
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POST_IMGS = STORAGE_BASE.child("post-imgs")
    private var _REF_PROFILE_IMGS = STORAGE_BASE.child("profile-imgs")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_SESSHS: FIRDatabaseReference {
        return _REF_SESHHS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    
    var REF_POST_IMGS: FIRStorageReference {
        return _REF_POST_IMGS
    }
    
    var REF_PROFILE_IMGS: FIRStorageReference {
        return _REF_PROFILE_IMGS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
        
        
    }
    
}
