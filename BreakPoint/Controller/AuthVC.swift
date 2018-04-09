//
//  AuthVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signInWithEmailBtnPressed(_ sender: Any) {
    let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil) //go to the loginVC
    }
    
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
    }
    
    
}
