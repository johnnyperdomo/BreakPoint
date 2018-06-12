//
//  UserCell.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/16/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    var showing = false //if checkmark is showing
    
    func configureCell(email:String, isSelected: Bool) {
        self.emailLbl.text = email
        if isSelected { //if user is selected
            self.checkImg.isHidden = false
        } else {
            self.checkImg.isHidden = true
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) { //to hide or show the checkmark
        super.setSelected(selected, animated: animated)
        if selected { //if we've tapped on the cell
            if showing == false { //if it's not showing, we're gonna show it
                checkImg.isHidden = false
                showing = true //set showing to be true
            } else {
                checkImg.isHidden = true
                showing = false
            }
        }
    }
}
