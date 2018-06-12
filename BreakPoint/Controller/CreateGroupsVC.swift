//
//  CreateGroupsVCViewController.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/15/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleTxtField: InsetTextField!
    @IBOutlet weak var descTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
  
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) //use this to monitor our txtField; monitors when text changes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true //makes doneBtn hidden from the beginning
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
        if titleTxtField.text != "" && descTextField.text != "" { //if these two fields are not empty...
            DataService.instance.getIDs(forUsernames: chosenUserArray) { (idsArray) in //usernames are picked from the chosenUserArray that gets filled when we pick members
                
                var userIds = idsArray //temporary variable that holds the idsArray
                userIds.append((Auth.auth().currentUser?.uid)!) //add ourselves to the group.
                
                DataService.instance.createGroup(withTitle: self.titleTxtField.text!, andDescription: self.descTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    
                    if groupCreated { //if the group is created successfully
                        self.dismiss(animated: true, completion: nil) //dismiss VC
                    } else {
                        print("group couldn't be created")
                    }
                    
                })
            }
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //emails in the rows for the search Query
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")  as? UserCell else { return UITableViewCell() }
        
        if chosenUserArray.contains(emailArray[indexPath.row]){ //to check if we have already tapped on a member to be added to the array
            cell.configureCell(email: emailArray[indexPath.row], isSelected: true) //pulls the email from the proper row
        } else { //if they're not in array
            cell.configureCell(email: emailArray[indexPath.row], isSelected: false) //sets the checkmark to be hidden
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return } //cell for row lets us get the cell and add it to our value
        
        if !chosenUserArray.contains(cell.emailLbl.text!) { //to check whether the user Array has the email already inside; (!) means does not
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ") //adds the emails, with a comma , in between
            doneBtn.isHidden = false //donebtn shows if we add a user
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! }) //filter is like a forloop, it filters the array, you can use $0 as a temporary variable; returns everybody who is not = to emailLbl.text
            
            if chosenUserArray.count >= 1 { //if there's atleast one person in the array
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else { //if there are 0 members in the array
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true //hides the doneBtn if we remove all users from the array
            }
        }
    }
    
}






