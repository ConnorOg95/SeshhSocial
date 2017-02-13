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
        
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 15.0
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
