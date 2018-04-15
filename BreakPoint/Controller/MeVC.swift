//
//  MeVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/9/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email //matches the emailLbl
    }
    
    @IBAction func signOutBtnPressed(_ sender: Any) { //used to sign out the app
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet) //puts an alert on screen
        
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in //when btn tapped, we will log out
            do { //it throws so do catch block
                try Auth.auth().signOut() //signs out
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC //presents authVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopUp.addAction(logoutAction) //to add it to the popup
        present(logoutPopUp, animated: true, completion: nil) //call the popup
    }
}
