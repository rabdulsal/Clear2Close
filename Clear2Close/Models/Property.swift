//
//  Property.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

class C2CProperty {
    
    enum PropertyType : String {
        case Rental = "rental"
        case Flip = "flip"
    }
    
    var address: String
    var propertyType: PropertyType
    
    init(address: String, propertyType: PropertyType) {
        self.address = address
        self.propertyType = propertyType
    }
}
