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
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.seshhDescriptionTxtView.text = post.seshhDescription
        self.seshhLikesLbl.text = "\(post.seshhLikes)"
        self.seshhTitleLbl.text = post.seshhTitle
        self.seshhLocationLbl.text = post.seshhLocation
        self.seshhCategoryLbl.text = post.seshhCategory
        
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
    }
}
