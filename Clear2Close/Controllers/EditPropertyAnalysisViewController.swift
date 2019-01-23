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
    @IBOutlet weak var purchaseField: UITextField!
    @IBOutlet weak var rehabField: UITextField!
    @IBOutlet weak var appraisalField: UITextField!
    @IBOutlet weak var interestField: UITextField!
    @IBOutlet weak var pointsField: UITextField!
    @IBOutlet weak var termsField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    let segueID = "PreviewPropID"
    var property: C2CProperty!
    var deal: C2CDeal!
    var fundingSource: C2CDeal.FundingSource = .HardMoney
    
    override func viewDidLoad() {
        self.title = self.property.propertyType.rawValue
        self.propertyAddress.text = self.property.address
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        let previewPropertyVC = segue.destination as! PreviewPropertyAnalysisViewController
        previewPropertyVC.property = self.property
        previewPropertyVC.dealViewModel = C2CPropertyAnalysisModel(deal: self.deal)
        
    }
    
    @IBAction func pressedContinueButton(_ sender: Any) {
        guard
            let purchase = Double(self.purchaseField.text as! String),
            let rehab = Double(self.rehabField.text as! String),
            let appraisal = Double(self.appraisalField.text as! String),
            let interest = Double(self.interestField.text as! String),
            let points = Double(self.pointsField.text as! String),
            let terms = Int(self.termsField.text as! String) else { return }
        
        self.deal = C2CDeal(property: self.property, purchasePrice: purchase, rehab: rehab, appraisal: appraisal, funding: self.fundingSource, interest: interest, points: points, terms: terms)
        self.performSegue(withIdentifier: self.segueID, sender: nil)
    }
    
    
}
