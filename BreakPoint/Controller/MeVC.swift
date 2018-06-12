//
//  MeVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/9/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var downloadedProfileURL = String() //to store downloaded url strings for images
    let appdelegate = AppDelegate() //app delegate

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var updateBioLbl: InsetUILabel!
    @IBOutlet weak var updateImageBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBioLbl.layer.borderWidth = 1
        updateBioLbl.layer.borderColor = #colorLiteral(red: 0.9017186761, green: 0.4714548588, blue: 0, alpha: 1)
        updateBioLbl.layer.cornerRadius = 8
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
        updateImageBtn.layer.cornerRadius = 8
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            DataService.instance.downloadProfileImageURL(forUID: (Auth.auth().currentUser?.uid)!) { (returnedURL) in //to call the downloadImage function
                
                self.downloadedProfileURL = returnedURL
                
                if returnedURL == "" { //if there is no image chosen, there isn't going to be a url
                    print("user has no profile image")
                    return
                } else {
                    print("successfully download profile image")
                    DataService.instance.downloadProfileImage(forUID: (Auth.auth().currentUser?.uid)!, forImageURL: self.downloadedProfileURL, image: self.profileImg, complete: { (success) in
                        
                        if success {
                            print("image works")
                        }
                    })
                }
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email //matches the emailLbl
        
        if Auth.auth().currentUser != nil {
            
            DataService.instance.getBiographies(forUserId: (Auth.auth().currentUser?.uid)!) { (returnedBiographies) in //downloads biography message
                self.updateBioLbl.text = returnedBiographies //sets the downloaded biography message as the biography label
            }
        }
    }
    
    
    @IBAction func updateBioBtnPressed(_ sender: Any) {
        let updateBioVC = storyboard?.instantiateViewController(withIdentifier: "updateBioVC")
        present(updateBioVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func updateImageBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController() //lets us choose an image
        
        picker.delegate = self //delegate
        picker.allowsEditing = true //allows us to edit image
        
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func signOutBtnPressed(_ sender: Any) { //used to sign out the app
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet) //puts an alert on screen
        
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in //when btn tapped, we will log out
            
            
            
            do { //it throws so do catch block
                self.appdelegate.signOutOfGoogle() //signs out of google
                try Auth.auth().signOut() //signs out
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC //presents authVC
                self.present(authVC!, animated: true, completion: nil)
                self.profileImg.image = UIImage(named: "defaultProfileImage")
            } catch {
                print(error)
            }
        }
        
        
        logoutPopUp.addAction(logoutAction) //to add it to the popup
        present(logoutPopUp, animated: true, completion: nil) //call the popup
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { //if we cancel picking an image
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage? //to see if we selected an image
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImageFromPicker = editedImage as! UIImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as! UIImage
            
        }
   
        if let selectedImage = selectedImageFromPicker {
            profileImg.image = selectedImage
            
            DataService.instance.uploadProfileImageToStorage(withImage: selectedImage, forUID: (Auth.auth().currentUser?.uid)!) { (success) in
                
                if success {
                    print("successfully upload photo")
                    
                    DataService.instance.downloadProfileImageURL(forUID: (Auth.auth().currentUser?.uid)!) { (returnedURL) in //to call the downloadImage function
                        
                        if returnedURL == "" {
                            print("user has no profile image")
                            return
                        } else {
                            print("successfully download profile image")
                            DataService.instance.downloadProfileImage(forUID: (Auth.auth().currentUser?.uid)!, forImageURL: self.downloadedProfileURL, image: self.profileImg, complete: { (success) in
                                
                                if success {
                                    print("image works")
                                }
                            })
                        }
                        
                    }
                }
            }
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
