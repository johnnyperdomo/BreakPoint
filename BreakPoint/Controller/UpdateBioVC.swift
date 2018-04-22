//
//  updateBioVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/21/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class UpdateBioVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
