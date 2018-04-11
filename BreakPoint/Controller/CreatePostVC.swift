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

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..." { //if user hasn't typed yet
            sendBtn.isEnabled = false //disable send btn
            
            //dont need a group key since its a public feed
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete { //if complete
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil) //dismiss VC
                } else {
                    self.sendBtn.isEnabled = true
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

