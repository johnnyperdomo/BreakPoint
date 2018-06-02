//
//  updateBioVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/21/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class UpdateBioVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        doneBtn.isHidden = true
    }

    
    @IBAction func doneBtnPressed(_ sender: Any) {
        DataService.instance.createBiography(withText: textView.text, forUID: (Auth.auth().currentUser?.uid)!) { (success) in
            
            if success { //if successful we dismiss view controller
                self.dismissDetail()
            }
        }
        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" && textView.text != "Type something..."  { //if we havent typed something
            doneBtn.isHidden = false
        } else {
            doneBtn.isHidden = true
        }
    }
}

