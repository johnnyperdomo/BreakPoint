//
//  UserCell.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/16/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    func configureCell(profileImg: UIImage, email:String, isSelected: Bool) {
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        if isSelected { //if user is selected
            self.checkImg.isHidden = false
        } else {
            self.checkImg.isHidden = true
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
