//
//  PropertySummaryEditCell.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/24/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class PropertySummaryEditCell : C2CBasicCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentField: UITextField!
    
    func configure(rowContent: C2CAnalysisService.SummaryRowData) {
        self.contentLabel.text = rowContent.rowLabel
        self.contentField.text = rowContent.rowValue
    }
}
