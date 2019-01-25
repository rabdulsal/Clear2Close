//
//  UIButton+Clear2Close.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/25/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class PrimaryCTAButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    func setBaseStyles() {
        self.setEnabledStyle()
        layer.cornerRadius = 5
    }
    
    func setEnabledStyle() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.C2CGreen
    }
}
