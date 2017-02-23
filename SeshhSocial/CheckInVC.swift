//
//  CheckInVC.swift
//  SeshhSocial
//
//  Created by User on 17/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class CheckInVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var descriptionTxtFld: UITextField!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var locationTxtFld: UITextField!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var imagePicker: UIImagePickerController!
    var imgSelected = false
    var userRef: FIRDatabaseReference!
    var categorySelected = false
    
    let categories = ["Drinks Seshh", "Active Seshh", "Sports Seshh", "Recreational Seshh", "Music Seshh", "Entertainment Seshh"]

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
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
        guard let _ = categoryBtn.titleLabel, categorySelected == true else {
            // ERROR MESSAGE TO USER - CATEGORY REQUIRED TO CHECK IN.
            print("CONNOR: Category must be entered to check in")
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
                    if let url = downloadURL {
                    self.postToFirebase(imgURL: url)
                    self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func postToFirebase(imgURL: String) {
        
        userRef = DataService.ds.REF_USER_CURRENT.child("username")
        // NEED TO GET USERNAME VALUE FROM THIS REFERENCE
        
        print("CONNOR: UserRef - \(userRef)")
        
        
        //CASTED ALL OBJECTS AS AnyObject
        
        let post: Dictionary<String, AnyObject> = [
        "description": descriptionTxtFld.text as AnyObject,
        "imageURL": imgURL as AnyObject,
        "likes": 0 as AnyObject,
        "category": categoryBtn.titleLabel!.text as AnyObject,
        "title": titleTxtFld.text as AnyObject,
        "location": locationTxtFld.text as AnyObject,
//        "username": userRef,
        ]
        
        let firebasePost = DataService.ds.REF_SESSHS.childByAutoId()
        firebasePost.setValue(post)
        
        descriptionTxtFld.text = ""
        imgSelected = false
        addImg.image = UIImage(named: "CameraIcon")
        titleTxtFld.text = ""
        locationTxtFld.text = ""
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryBtn.setTitle(categories[row], for: UIControlState.normal)
        categorySelected = true
        categoryBtn.isHidden = false
        categoryPicker.isHidden = true
        addImg.isHidden = false
        locationTxtFld.isHidden = false
    }
    
    @IBAction func categoryBtnPressed(_ sender: Any) {
        categoryBtn.isHidden = true
        categoryPicker.isHidden = false
        addImg.isHidden = true
        locationTxtFld.isHidden = true
    }
}
