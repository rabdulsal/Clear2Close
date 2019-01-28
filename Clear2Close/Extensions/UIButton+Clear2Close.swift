//
//  UIButton+Clear2Close.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/25/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func toggleSelected() {
        isSelected = !isSelected
    }
    
}

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

class CircularButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    func setBaseStyles() {
        // Shadow
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        // Button
        self.setUnSelectedStyle()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = layer.frame.width / 2
    }
    
    func setSelectedStyle() {
        layer.borderWidth = 0.0
        backgroundColor = UIColor.C2CGreen
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func setUnSelectedStyle() {
        layer.borderWidth = 1.0
        backgroundColor = UIColor.white
        setTitleColor(UIColor.C2CGreen, for: .normal)
    }
    
    override var isSelected: Bool {
        didSet {
            self.isSelected ? self.setSelectedStyle() : self.setUnSelectedStyle()
        }
    }
}
