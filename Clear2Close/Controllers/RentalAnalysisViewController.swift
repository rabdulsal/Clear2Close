//
//  RentalAnalysisViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/22/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class RentalAnalysisViewController : UIViewController {
    
    @IBOutlet weak var propertyAddress : UILabel!
    
    var property: C2CProperty!
    
    override func viewDidLoad() {
        self.title = self.property.propertyType.rawValue
        self.propertyAddress.text = self.property.address
    }
    
}
