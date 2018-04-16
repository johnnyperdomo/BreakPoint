//
//  AuthService.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/8/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import Foundation
import Firebase


class AuthService {
    static let instance = AuthService() //static lets variable be accessable throughout the entire lifecycle of the app
    
    //register a user
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) { //error is optional/nil cuz there isnt necessarily an error
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in //firebase authentication function
            guard let user = user else { //holds a value for the user, if it doesn't work it'll be false
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email] //dictionary of user data
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData) //if we have a user, he will be sent to firebase database.
            userCreationComplete(true, nil) //true, no error
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) { //login a user
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error) //if not, error)
                return
            }
            loginComplete(true, nil) //success
        }
    }
}
