//
//  EditRentalAnalysisViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/22/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class EditRentalAnalysisViewController : UIViewController {
    /*
     Edit Rental Analysis and Property Funding Source
    */
    
    @IBOutlet weak var propertyAddress : UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    let segueID = "PreviewPropID"
    var property: C2CProperty!
    
    override func viewDidLoad() {
        self.title = self.property.propertyType.rawValue
        self.propertyAddress.text = self.property.address
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        let previewPropertyVC = segue.destination as! PreviewPropertyAnalysisViewController
        previewPropertyVC.property = self.property
        
    }
    
    @IBAction func pressedContinueButton(_ sender: Any) {
        self.performSegue(withIdentifier: self.segueID, sender: nil)
    }
    
    
}
