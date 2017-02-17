//
//  ProfileImageView.swift
//  SeshhSocial
//
//  Created by User on 17/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 45
        layer.masksToBounds = true
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//                layer.cornerRadius = self.frame.width / 2
//    }
}
