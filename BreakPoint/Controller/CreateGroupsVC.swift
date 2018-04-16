//
//  CreateGroupsVCViewController.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/15/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleTxtField: InsetTextField!
    @IBOutlet weak var descTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
  
    var emailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) //use this to monitor our txtField; monitors when text changes
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" { //if txtfield is empty
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!) { (returnedEmailArray) in //pass in the query, once we start typing it'll search for emails
                self.emailArray = returnedEmailArray //fills our email array with the emails we pull from firebase
                self.tableView.reloadData() //reloads so we see it
            }
        }
    }
    

    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count //takes the count of emailArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")  as? UserCell else { return UITableViewCell() }
        let profileimg = UIImage(named: "defaultProfileImage")
        
        cell.configureCell(profileImg: profileimg!, email: emailArray[indexPath.row], isSelected: true) //pulls the email from the proper row
        return cell
    }
    
}






