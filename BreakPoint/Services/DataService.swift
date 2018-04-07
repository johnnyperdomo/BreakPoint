//
//  DataService.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

//to handle data

import Foundation
import Firebase

let DB_BASE = Database.database().reference() //Base Url

class DataService {
    static let instance = DataService()
    
    //these are private so that you can only set it here
    private var _REF_BASE = DB_BASE //this is our Database URL
    private var _REF_USERS = DB_BASE.child("users") //used to save users into their own folder in firebase;
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    
    //we use these regular variables to be able to access the data later on...since they are not private
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) { //func to get users and push that data into FireBase to make a database; user-identification-id(uid)
        REF_USERS.child(uid).updateChildValues(userData) // make a firebase user
    }
    
    
    
    
    
    
    
    
    
}