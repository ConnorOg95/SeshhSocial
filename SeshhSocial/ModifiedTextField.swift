//
//  ModifiedTextField.swift
//  SeshhSocial
//
//  Created by User on 13/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit

class ModifiedTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//        layer.borderWidth = 1.0
//        layer.cornerRadius = 15.0
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.black.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
