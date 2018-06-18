//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/19/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTxtField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet var mainView: UIView!
    
    var downloadedProfileURL = String()
    var group: Group? //to hold the data for the group; optional just in case we dont have a value
    var groupMessages = [Message]() //hold the values
    
    func initGroupData(forGroup group: Group) {
        self.group = group
        
    }
    
    override func viewWillAppear(_ animated: Bool) { //to be able to pass in groups data to another view
        super.viewWillAppear(animated)
        
        groupTitleLbl.text = group?.groupTitle //accesses Group Data model to get the correct data
        DataService.instance.getEmailsFor(group: group!) { (returnedEmails) in //this func turns ids into emails
            self.membersLbl.text = returnedEmails.joined(separator: ", ") //Array, separate it with comma
        }
        
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in //if there are any changes, observe them, and implement them here
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 { //there has to be atleast one message in the group
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true) //tableView scrolls to latest message; row goes to bottom of the messages depending on number of messages... -1 becuase array indexing starts at 0 but .count starts at 1
                }
                
                
                
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.bindToKeyboard() //binds to keyboard
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail() //dismissed the VC with a custom animation
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if messageTxtField.text != "" { //if its not empty
            messageTxtField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key) { (complete) in
                
                if complete { //if this is complete
                    self.messageTxtField.text = "" //empty the text field so we dont send it twice
                    self.messageTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }
    
 
    //TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        
        let message = groupMessages[indexPath.row] //to get the content

        
        DataService.instance.downloadProfileImageURL(forUID: message.senderId) { (returnedURL) in //to call the downloadImage function
            
            self.downloadedProfileURL = returnedURL
            
            
            if returnedURL == "" { //if there is no image chosen, there isn't going to be a url
                print("user has no profile image")
                return
            } else {
                print("successfully download profile image")
                DataService.instance.downloadProfileImage(forUID: message.senderId, forImageURL: self.downloadedProfileURL, image: cell.imageView!, complete: { (success) in
                    
                    if success {
                        cell.imageView?.layer.cornerRadius = 42
                        cell.imageView?.layer.masksToBounds = true
                        
                    }
                })
                
            }
        }
        
        DataService.instance.getUsername(forUID: message.senderId) { (email) in //gets the email from the senderid
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, message: message.content)
        }
        
        return cell
    }
    
    
}
