//
//  AuthVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

     override func viewDidAppear(_ animated: Bool) { //called everytime when view appears, not just when it loads for the first time
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil { //if theres a user, dismiss the view controller
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInWithEmailBtnPressed(_ sender: Any) {
    let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil) //go to the loginVC
    }
    
}
