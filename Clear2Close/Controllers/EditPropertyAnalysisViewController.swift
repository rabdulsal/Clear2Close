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
    @IBOutlet weak var continueButton: PrimaryCTAButton!
    @IBOutlet weak var hardMoneyButton: CircularButton!
    @IBOutlet weak var privateMoneyButton: CircularButton!
    @IBOutlet weak var cashButton: CircularButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    fileprivate var keyboardService: C2CKeyboardService!
    
    let segueID = "PreviewPropID"
    var property: C2CProperty!
    var deal: C2CDeal!
    var fundingSource: C2CDeal.FundingSource = .HardMoney
    private var radioButtonVM: C2CRadioButtonViewModel!
    
    override func viewDidLoad() {
        self.title = self.property.propertyType.rawValue
        self.propertyAddress.text = self.property.address
        self.keyboardService = C2CKeyboardService(self.scrollView)
        self.radioButtonVM = C2CRadioButtonViewModel([self.hardMoneyButton, self.privateMoneyButton, self.cashButton])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardService.beginObservingKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboardService.endObservingKeyboard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let previewPropertyVC = segue.destination as! PreviewPropertyAnalysisViewController
        previewPropertyVC.property = self.property
        previewPropertyVC.dealViewModel = C2CPropertyAnalysisModel(deal: self.deal)
    }
    
    // MARK: ACTIONS
    
    @IBAction func pressedHardMoney(_ sender: CircularButton) {
        self.fundingSource = .HardMoney
        self.radioButtonVM.selectButton(sender.tag)
    }
    
    @IBAction func pressedPrivate(_ sender: CircularButton) {
        self.fundingSource = .Private
        self.radioButtonVM.selectButton(sender.tag)
    }
    
    @IBAction func pressedCash(_ sender: CircularButton) {
        self.fundingSource = .Cash
        self.radioButtonVM.selectButton(sender.tag)
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
