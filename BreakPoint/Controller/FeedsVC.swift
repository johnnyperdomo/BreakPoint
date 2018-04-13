//
//  FirstViewController.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class FeedsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]() //this is an array of message so that when we call it, it shows the messages in the feed TableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    //download all messages and fill up our local array in feedVC
    override func viewDidAppear(_ animated: Bool) { //called before viewDidload
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray //now its downloaded and our array is the same
            self.tableView.reloadData() //reloads the tableViewData
        }
    }
    

}

extension FeedsVC: UITableViewDelegate, UITableViewDataSource {
    
    //these 3 are required for a tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count //shows number of messages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //our cell needs an image, a message, and email
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() } //if we dont get a value, returns an empty cell
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row] //gets messages in order

        cell.configureCell(profileImage: image!, email: message.senderId, messageContent: message.content) //configure the cell, this updates the values in the cell according to the pulled data
        return cell
    }
}

