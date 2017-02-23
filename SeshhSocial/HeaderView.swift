//
//  HeaderView.swift
//  SeshhSocial
//
//  Created by User on 22/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.8).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
