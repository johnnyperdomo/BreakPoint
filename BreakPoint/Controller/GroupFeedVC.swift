//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/19/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTxtField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    var group: Group? //to hold the data for the group; optional just in case we dont have a value
    
    func initGroupData(forGroup group: Group) {
        self.group = group
        
    }
    
    override func viewWillAppear(_ animated: Bool) { //to be able to pass in groups data to another view
        super.viewWillAppear(animated)
        
        groupTitleLbl.text = group?.groupTitle //accesses Group Data model to get the correct data
        DataService.instance.getEmailsFor(group: group!) { (returnedEmails) in //this func turns ids into emails
            self.membersLbl.text = returnedEmails.joined(separator: ", ") //Array, separate it with comma
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard() //binds to keyboard
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
    }
    
    
}
