//
//  LoginVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTxtField: InsetTextField!
    @IBOutlet weak var passwordTxtField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) { //register a user
        if emailTxtField.text != nil && passwordTxtField.text != nil { //if there is information in both
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passwordTxtField.text!) { (success, loginError) in
                if success { //if we log in successfully
                    self.dismiss(animated: true, completion: nil)
                   
                } else { //if we dont successfully login
                    print(String(describing: loginError?.localizedDescription))
                }
                
                //if we've never logged in, try to register them
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, loginComplete: { (success, nil) in //cant get an error
                            let pickImageVC = self.storyboard?.instantiateViewController(withIdentifier: "pickImageVC") as? PickImageVC //if new user, make profile image
                            self.present(pickImageVC!, animated: true, completion: nil)
                            print("Successfully registered user")
                        })
                    } else { //if fail to register user
                       print(String(describing: registrationError?.localizedDescription))
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil { //if theres a user, dismiss the view controller
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


