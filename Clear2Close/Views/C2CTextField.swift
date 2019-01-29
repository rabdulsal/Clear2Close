//
//  C2CTextField.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/29/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class C2CNumericField : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardType = .numberPad
    }
}
