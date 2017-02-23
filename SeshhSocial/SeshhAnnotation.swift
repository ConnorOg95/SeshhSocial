//
//  SeshhAnnotation.swift
//  SeshhSocial
//
//  Created by User on 23/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import Foundation
import MapKit

let seshhCategory = ["Drinks", "Active", "Recreational", "Sports", "Entertainment", "Music"]

class SeshhAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var seshhNumber: Int
    var seshhName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, seshhNumber: Int) {
        self.coordinate = coordinate
        self.seshhNumber = seshhNumber
        self.seshhName = seshhCategory[seshhNumber - 1].capitalized
        self.title = self.seshhName
    }
    
    
}
