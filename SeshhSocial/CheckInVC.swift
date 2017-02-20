//
//  CheckInVC.swift
//  SeshhSocial
//
//  Created by User on 17/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class CheckInVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var descriptionTxtFld: UITextField!
    
    var imagePicker: UIImagePickerController!
    var imgSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImg.image = image
            imgSelected = true
        } else {
            print("CONNOR: Valid image was not selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func addImgPressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func checkInBtnPressed(_ sender: Any) {
        
        guard let description = descriptionTxtFld.text, description != "" else {
            // ERROR MESSAGE TO USER - DESCRIPTION REQUIRED TO CHECK IN.
            print("CONNOR: Description must be entered to check in")
            return
        }
        guard  let img = addImg.image, imgSelected == true else {
            // ERROR MESSAGE TO USER - IMAGE SELECTION REQUIRED TO CHECK IN.
            print("CONNOR: Image must be selected to check in")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMGS.child(imgUid).put(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    // ERROR MESSAGE TO USER - FAILED TO UPLOAD IMAGE.
                    print("CONNOR: Unable to upload image to Firebase Storage")
                } else {
                    print("CONNOR: Sucessfully uploaded image to Firebase Storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                }
            }
        }
    }
    
}
