//
//  PreviewPropertyAnalysisViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class PreviewPropertyAnalysisViewController : UIViewController {
    
    /*
     Preview Rental Analysis info in checkered TableView
     */
    
    
    
    @IBOutlet weak var propertyAddressLabel : UILabel!
    @IBOutlet weak var propertyTableView : UITableView!
    
    var property: C2CProperty!
    
    override func viewDidLoad() {
        self.title = "Preview Analysis"
        self.propertyAddressLabel.text = self.property.address
    }
    
    @IBAction func pressedContinueButton(_ sender: Any) {
        
    }
    
}
