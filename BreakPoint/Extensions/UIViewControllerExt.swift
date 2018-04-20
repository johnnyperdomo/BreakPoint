//
//  UIViewControllerExt.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/20/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

extension UIViewController { //to animate the view controller
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition() //hold the value
        transition.duration = 0.3 //lasts 0.3 seconds
        transition.type = kCATransitionPush //it pushes in the view
        transition.subtype = kCATransitionFromRight //transitions from the right
        self.view.window?.layer.add(transition, forKey: kCATransition) //add it
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() { //to dismiss VC with custom animation
        let transition = CATransition() //hold the value
        transition.duration = 0.3 //lasts 0.3 seconds
        transition.type = kCATransitionPush //it pushes in the view
        transition.subtype = kCATransitionFromLeft //transitions from the left
        self.view.window?.layer.add(transition, forKey: kCATransition) //add it
        
        dismiss(animated: false, completion: nil)
    }
    
}
