//
//  PreviewAnalysisCell.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/23/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class PreviewAnalysisCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    func configure(viewModel: C2CPropertyAnalysisModel.DealViewModel) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
}
