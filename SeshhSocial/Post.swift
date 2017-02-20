//
//  Post.swift
//  SeshhSocial
//
//  Created by User on 19/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import Foundation

class Post {
    
    private var _seshhTitle: String!
    private var _seshhDescription: String!
    private var _seshhCategory: String!
    private var _seshhLocation: String!
    private var _seshhLikes: Int!
    private var _seshhImgURL: String!
    private var _seshhPostKey: String!
    
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
    
    init(seshhTitle: String, seshhCategory: String, seshhLocation: String, seshhDescription: String, seshhImgURL: String, seshhLikes: Int) {
        self._seshhTitle = seshhTitle
        self._seshhCategory = seshhCategory
        self._seshhLocation = seshhLocation
        self._seshhDescription = seshhDescription
        self._seshhImgURL = seshhImgURL
        self._seshhLikes = seshhLikes
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
        
    }
}
