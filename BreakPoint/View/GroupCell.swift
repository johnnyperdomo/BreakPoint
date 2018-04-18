//
//  GroupCell.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/17/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members." //members is of type Int; creates a string version of the number
        
    }
    
}
