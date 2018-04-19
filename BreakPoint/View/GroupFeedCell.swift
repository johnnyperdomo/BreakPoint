//
//  GroupFeedCell.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/19/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, message: String) {
        self.profileImg.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = message
    }
    
    
}
