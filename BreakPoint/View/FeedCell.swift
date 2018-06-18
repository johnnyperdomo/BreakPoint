//
//  FeedCell.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/12/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, messageContent: String) {
        self.profileImg.image = profileImage
        self.emailLbl.text = email
        self.messageContentLbl.text = messageContent
    }
    
}
