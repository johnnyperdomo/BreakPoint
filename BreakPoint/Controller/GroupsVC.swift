//
//  SecondViewController.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupsTableView: UITableView!
    
    var groupsArray = [Group]() //local array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in //observe everything so our tableView gets updated in real time
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                self.groupsTableView.reloadData()
            }
        }
    }
    
    
    
    //table view (required extensions)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        let group = groupsArray[indexPath.row] //pulls out the cell at particular row
        
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //present a custom thing when we tap on a row
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return } //to move between view controllers
        groupFeedVC.initGroupData(forGroup: groupsArray[indexPath.row]) //initializes some Group data and passes it into this VC
        presentDetail(groupFeedVC) //present the view controller with a custom animation 
    }
    
    
    
}

