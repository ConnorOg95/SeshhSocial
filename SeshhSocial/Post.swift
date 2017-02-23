//
//  Post.swift
//  SeshhSocial
//
//  Created by User on 19/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _seshhTitle: String!
    private var _seshhDescription: String!
    private var _seshhCategory: String!
    private var _seshhLocation: String!
    private var _seshhLikes: Int!
    private var _seshhImgURL: String!
    private var _seshhPostKey: String!
    private var _seshhPostRef: FIRDatabaseReference!
    private var _seshhUsername: String!
    private var _seshhProfileImgURL: String!
    
    var userRef: FIRDatabaseReference!
    
    var seshhTitle: String {
        return _seshhTitle
    }
    
    var seshhDescription: String {
        return _seshhDescription
    }
    
    var seshhCategory: String {
        return _seshhCategory
    }

    var seshhLocation: String {
        return _seshhLocation
    }
    
    var seshhLikes: Int {
        return _seshhLikes
    }
    
    var seshhImgURL: String {
        return _seshhImgURL
    }
    
    var seshhPostKey: String {
        return _seshhPostKey
    }
    
    var seshhUsername: String {
        return _seshhUsername
    }
    
//    var seshhProfileImgURL: String {
//        return _seshhProfileImgURL
//    }
    
    init(seshhTitle: String, seshhCategory: String, seshhLocation: String, seshhDescription: String, seshhImgURL: String, seshhLikes: Int, seshhUsername: String) {
        self._seshhTitle = seshhTitle
        self._seshhCategory = seshhCategory
        self._seshhLocation = seshhLocation
        self._seshhDescription = seshhDescription
        self._seshhImgURL = seshhImgURL
        self._seshhLikes = seshhLikes
        self._seshhUsername = seshhUsername
//        self._seshhProfileImgURL = seshhProfileImgURL
    }
    
    init(seshhPostKey: String, postData: Dictionary<String, AnyObject>) {
        self._seshhPostKey = seshhPostKey
        
        if let seshhDescription = postData["description"] as? String {
            self._seshhDescription = seshhDescription
        }
        
        if let seshhImgURL = postData["imageURL"] as? String {
            self._seshhImgURL = seshhImgURL
        }
        
        if let seshhLikes = postData["likes"] as? Int {
            self._seshhLikes = seshhLikes
        }
        
        if let seshhCategory = postData["category"] as? String {
            self._seshhCategory = seshhCategory
        }
        
        if let seshhTitle = postData["title"] as? String {
            self._seshhTitle = seshhTitle
        }
        
        if let seshhLocation = postData["location"] as? String {
            self._seshhLocation = seshhLocation
        }
        
        if let  postUser = postData["uid"] as? String {
            print("CONNOR: uid for post user \(postUser)")
            userRef = DataService.ds.REF_USER_CURRENT.child("info")
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? Dictionary<String, AnyObject> {
                    let username = value["username"] as! String
                    self._seshhUsername = username
                    print("CONNOR: usernameee \(username)")
                }
            })
        }
        
//        if let seshhUsername = postData["username"] as? String {
//            self._seshhUsername = seshhUsername
//        }
//        
//        if let seshhProfileImgURL = postData["profileImgURL"] as? String {
//            self._seshhProfileImgURL = seshhProfileImgURL
//        }
        
        _seshhPostRef = DataService.ds.REF_SESSHS.child(_seshhPostKey)
        
    }
    
    func adjustLikes(addLike: Bool) {
        
        if addLike {
            _seshhLikes = _seshhLikes + 1
        } else {
            _seshhLikes = _seshhLikes - 1
        }
        _seshhPostRef.child("likes").setValue(_seshhLikes)
        
        
    }
}
