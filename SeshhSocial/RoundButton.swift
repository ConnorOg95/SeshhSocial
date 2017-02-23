//
//  RoundButton.swift
//  SeshhSocial
//
//  Created by User on 13/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 4.0
//        imageView?.contentMode = .scaleAspectFit
    }
}
