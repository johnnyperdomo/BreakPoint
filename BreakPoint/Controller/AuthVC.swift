//
//  AuthVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthVC: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var emailSignInBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGoogleButton()
    }

    fileprivate func setUpGoogleButton() {
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let googleBtn = GIDSignInButton()
        googleBtn.frame = CGRect(x: emailSignInBtn.frame.minX, y: emailSignInBtn.frame.maxY + 40, width: emailSignInBtn.frame.width, height: emailSignInBtn.frame.height)
        shadowView.addSubview(googleBtn)
        
    }
    
     override func viewDidAppear(_ animated: Bool) { //called everytime when view appears, not just when it loads for the first time
        super.viewDidAppear(animated)
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() { //if there's a google user
            dismiss(animated: true, completion: nil)
        } else if Auth.auth().currentUser != nil { //if theres a user, dismiss the view controller
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func signInWithEmailBtnPressed(_ sender: Any) {
    let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil) //go to the loginVC
    }
    
    
    
}

