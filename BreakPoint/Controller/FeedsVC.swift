//
//  FirstViewController.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class FeedsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var downloadedProfileURL = String()
    var downloadedImage = UIImageView()
    
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
            self.messageArray = returnedMessagesArray.reversed() //now its downloaded and our array is the same; 'reversed' reverses the order of the array and shows the most recent message at the top of the tableView
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
        let defaultImage = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row] //gets messages in order
        
        DataService.instance.downloadProfileImageURL(forUID: message.senderId) { (returnedURL) in //to call the downloadImage function
            
            self.downloadedProfileURL = returnedURL
            
            if returnedURL == "" { //if there is no image chosen, there isn't going to be a url
                print("user has no profile image")
                return
            } else {
                print("successfully download profile image")
                DataService.instance.downloadProfileImage(forUID: message.senderId, forImageURL: self.downloadedProfileURL, image: cell.imageView!, complete: { (success) in
                    
                    if success {
                        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.height)! / 2
                        cell.imageView?.layer.masksToBounds = true
                    }
                })
            }
        }
        
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in //the returnedUsername is our email that we pulled
            cell.configureCell(profileImage: defaultImage!, email: returnedUsername, messageContent: message.content) //configure the cell, this updates the values in the cell according to the pulled data
        }
        
        
        return cell
    }
}

