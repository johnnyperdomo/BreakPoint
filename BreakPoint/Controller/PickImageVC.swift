//
//  PickImageVC.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 6/9/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Firebase

class PickImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var chooseImgBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImgBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController() //lets us choose an image
        
        picker.delegate = self //delegate
        picker.allowsEditing = true //allows us to edit image
        
        present(picker, animated: true, completion: nil)
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
            profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        if profileImg.image != UIImage(named: "defaultProfileImage") {
            DataService.instance.uploadProfileImageToStorage(withImage: self.profileImg.image!, forUID: (Auth.auth().currentUser?.uid)!) { (success) in
                if success {
                    print("upload photo Successfully")
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
