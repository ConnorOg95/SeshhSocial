//
//  PostCell.swift
//  SeshhSocial
//
//  Created by User on 19/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var seshhCategoryLbl: UILabel!
    @IBOutlet weak var seshhTitleLbl: UILabel!
    @IBOutlet weak var seshhDescriptionTxtView: UITextView!
    @IBOutlet weak var seshhPhotoImg: UIImageView!
    @IBOutlet weak var seshhLikesLbl: UILabel!
    @IBOutlet weak var seshhLocationLbl: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var seshhCategoryImg: ProfileImageView!
    
    var post: Post!
    var likesRef: FIRDatabaseReference!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        starImg.addGestureRecognizer(tap)
        starImg.isUserInteractionEnabled = true
        
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.seshhPostKey)
        
        self.seshhDescriptionTxtView.text = post.seshhDescription
        self.seshhLikesLbl.text = "\(post.seshhLikes)"
        self.seshhTitleLbl.text = post.seshhTitle
        self.seshhLocationLbl.text = post.seshhLocation
        self.seshhCategoryLbl.text = post.seshhCategory
        self.nameLbl.text = post.seshhUsername
        
        if post.seshhCategory == "Drinks Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "DrinksCatIcon")
        } else if post.seshhCategory == "Active Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "ActiveCatIcon")
        } else if post.seshhCategory == "Music Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "MusicCatIcon")
        } else if post.seshhCategory == "Recreational Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "RecreationalCatIcon")
        } else if post.seshhCategory == "Entertainment Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "EntertainmentCatIcon")
        } else if post.seshhCategory == "Sports Seshh" {
            self.seshhCategoryImg.image = UIImage(named: "SportsCatIcon")
        }
        
        if img != nil {
            self.seshhPhotoImg.image = img
        } else {
                let ref = FIRStorage.storage().reference(forURL: post.seshhImgURL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("CONNOR: Unable to download image from Firebase")
                    } else {
                        print("CONNOR: Image download from Firebase successful")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.seshhPhotoImg.image = img
                                SeshhFeedVC.imageCache.setObject(img, forKey: post.seshhImgURL as NSString)
                            }
                        }
                    }
                    })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.starImg.image = UIImage(named: "StarIcon")
            } else {
                self.starImg.image = UIImage(named: "GoldStarIcon")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
    
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.starImg.image = UIImage(named: "GoldStarIcon")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.starImg.image = UIImage(named: "StarIcon")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }
}
