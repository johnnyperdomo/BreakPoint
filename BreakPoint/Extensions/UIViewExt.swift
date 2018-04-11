//
//  UIViewExt.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/11/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

extension UIView { //extends the uiview
    
    func bindToKeyboard() { //bind objects to keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double //we are pulling out the duration of the keyboard when it slides up, and getting it as a double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt //gets the same animation curve as the keyboard
        let beginningframe = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue //frame when keyboard is at the bottom beginning
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //frame when keyboard is at the top
        let deltaY = endFrame.origin.y - beginningframe.origin.y //delta is change over the y axis, so we know how far the keyboard moves up
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY //deltaY is how far the keyboard goes up, so we add that length to the position of the object frame we wanna move up
        }, completion: nil)
    }
    
    
}
