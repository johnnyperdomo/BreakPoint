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
    
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) { //func to convert uid into a username
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return } //allobjects pulls all users
            
            for user in userSnapshot {
                if user.key == uid { //if the user's key matches the uid we pass in
                    handler(user.childSnapshot(forPath: "email").value as! String) //find the user that matches the user id and gets the email back
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) { //upload a post to the feed and add it to the firebase Database //'groupkey' is whether its being posted in group or public feed
        
        if groupKey != nil { //if there is a group key
        //send to groups ref
        } else { //if it doesn't have a group key, post into the public feed
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid]) //childByAutoId() gives each message a custom random ID// each message needs content and a sender id
            sendComplete(true)
        }
    }
    
    //to pull the feed messages from the database.
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) { //this pulls an array of our message model, we can pass this message back to view controller
        
        var messageArray = [Message]() //array of type message to pass it into
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in //this downloads every message from the feed database, and saves it into a snapshot from firebase
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return} //allobjects pulls all messages from the feed
            
            for message in feedMessageSnapshot { //loop through all messages in feed, pull out content and senderId
                let content = message.childSnapshot(forPath: "content").value as! String //we dont want the key, we want the value( which is the message); cast as string
                let senderId = message.childSnapshot(forPath: "senderID").value as! String //pulls out the sender id from the snapshot
                let message = Message(content: content, senderId: senderId) //create a message by initializing it, using it from firebase
                messageArray.append(message) //append the message we created to the Message Array
            }
            //once we finish cycling call the completion handler
            handler(messageArray) //calls message array
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) { //func to find emails by search
        var emailArray = [String]() //array of type email
        
        REF_USERS.observe(.value) { (userSnapshot) in //observe every User
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot { //loops through users to get email
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email { //if email contains the query, and is not our own email
                    emailArray.append(email) //add the email to the email array
                }
            }
            
            handler(emailArray)
        }
    }
    
    func getIDs(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) { //to gets ids from the emails
        
        var idArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if usernames.contains(email) { //if it contains an email
                    idArray.append(user.key) //append their id to idArray
                }
            }
            handler(idArray)
        }
    }
    
    //to successfully create a group with members...and send it to firebase later
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids]) //make a dictionary to store groups data
        handler(true)
    }
    
}














