//
//  insetUILabel.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 6/2/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

@IBDesignable class InsetUILabel: UILabel { //to add padding to uilabel
    
    @IBInspectable var topInset: CGFloat = 5
    @IBInspectable var bottomInset: CGFloat = 5
    @IBInspectable var leftInset: CGFloat = 5
    @IBInspectable var rightInset: CGFloat = 5
    

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
       
}
