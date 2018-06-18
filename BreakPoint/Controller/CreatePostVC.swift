//
//  CreatePostVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/10/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    var downloadedProfileURL = String()
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet var mainView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        mainView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) { //update the changes, view will appear
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email //matches the emailLbl
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
        
        if Auth.auth().currentUser != nil {
            DataService.instance.downloadProfileImageURL(forUID: (Auth.auth().currentUser?.uid)!) { (returnedURL) in //to call the downloadImage function
                
                self.downloadedProfileURL = returnedURL
                
                if returnedURL == "" { //if there is no image chosen, there isn't going to be a url
                    print("user has no profile image")
                    return
                } else {
                    print("successfully download profile image")
                    DataService.instance.downloadProfileImage(forUID: (Auth.auth().currentUser?.uid)!, forImageURL: self.downloadedProfileURL, image: self.profileImg, complete: { (success) in
                        
                        if success {
                            print("image works")
                            
                            self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2
                            self.profileImg.layer.masksToBounds = true
                        }
                    })
                }
            }
        }
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != "" && textView.text != "Say something here..." { //if user hasn't typed yet
            sendBtn.isEnabled = false //disable send btn
            
            //dont need a group key since its a public feed
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete { //if complete
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil) //dismiss VC
                } else {
                    self.sendBtn.isEnabled = false
                    print("There was an error")
                }
            }
        }
    }
    
    
}


extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = "" //clears it out when we start typing
    }
}

