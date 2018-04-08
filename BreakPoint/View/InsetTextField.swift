//
//  InsetTextField.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/7/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

//view for the textfields

class InsetTextField: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) //to add padding for the rectangle we type text in
    
    
    override func awakeFromNib() {
        
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]) //to customize the placeholder; change the color
        self.attributedPlaceholder = placeholder //set the placeholder
        
        super.awakeFromNib()
    }
    

    override func textRect(forBounds bounds: CGRect) -> CGRect { //looking at text in the rectangle without touching it or modifying it.
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect { //rectangle for actually typing text
        return UIEdgeInsetsInsetRect(bounds, padding)

    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect { //where the placeholder is
        return UIEdgeInsetsInsetRect(bounds, padding)

    }
    
}
