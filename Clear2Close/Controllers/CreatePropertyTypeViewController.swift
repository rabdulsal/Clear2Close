//
//  CreatePropertyTypeViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/21/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class CreatePropertyTypeViewController : UIViewController {
    /*
     --- BIG NOTES ---
     1. TextField for address entry (exclude city/state/zip for now)
     2. Buttons for 'Rental' and 'Flip' -- only 1 can be selected at a time
     3. Continue button disabled until TextField, & Rental/Flip selected
     */
    
    enum PropertyType : String {
        case Rental = "rental"
        case Flip = "flip"
    }
    
    enum PropertySegueID : String {
        case Rental = "RentalID"
        case Flip = "FlipID"
    }
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var rentalButton : CircularButton!
    @IBOutlet weak var flipButton: CircularButton!
    
    var property: C2CProperty!
    var propertySegue: PropertySegueID!
    private var radioButtonsVM: C2CRadioButtonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.radioButtonsVM = C2CRadioButtonViewModel([self.rentalButton, self.flipButton])
    }
    
    @IBAction func pressedRentalButton(_ sender: CircularButton) {
        self.propertySegue = .Rental
        self.radioButtonsVM.selectButton(sender.tag)
    }
    
    @IBAction func pressedFlipButton(_ sender: CircularButton) {
        self.propertySegue = .Flip
        self.radioButtonsVM.selectButton(sender.tag)
    }
    
    @IBAction func pressedContinueButton(_ sender: Any) {
        /*
         1. Create C2CProperty object
         2. Perform segue
        */
        guard let address = addressField.text else { return }
        var propertyType: C2CProperty.PropertyType
        var identifier: String?
        
        switch self.propertySegue! {
        case .Rental:
            
            propertyType = C2CProperty.PropertyType.Rental
            self.property = C2CProperty(address: address, propertyType: propertyType)
            identifier = PropertySegueID.Rental.rawValue
        case .Flip:
            propertyType = C2CProperty.PropertyType.Flip
            self.property = C2CProperty(address: address, propertyType: propertyType)
            identifier = PropertySegueID.Flip.rawValue
        }
        self.performSegue(withIdentifier: identifier!, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
         Switch on PropertyType and pass property object to 'Rental' vs. 'Flip' ViewController
         */
        guard
            let identifier = segue.identifier,
            let seg = PropertySegueID(rawValue: identifier) else { return }
        switch seg {
        case .Rental:
            let createPropertyVC = segue.destination as! EditRentalAnalysisViewController
            createPropertyVC.property = self.property
        case .Flip:
            // TODO: May eventually create a completely separate VC type for Flip properties
            let createPropertyVC = segue.destination as! EditRentalAnalysisViewController
            createPropertyVC.property = self.property
        }
    }
    
}
