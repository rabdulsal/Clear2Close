//
//  C2CRadioButtonViewModel.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/29/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class C2CRadioButtonViewModel {
    
    var buttons: Array<CircularButton>
    var selectedIndex: Int = 0
    
    init(_ buttons: Array<CircularButton>) {
        self.buttons = buttons
        self.configureButtonTags()
    }
    
    func selectButton(_ index: Int) {
        self.buttons[self.selectedIndex].setUnSelectedStyle()
        self.buttons[index].setSelectedStyle()
        self.selectedIndex = index
    }
}

private extension C2CRadioButtonViewModel {
    
    func configureButtonTags() {
        for i in 0..<self.buttons.count {
            self.buttons[i].tag = i
        }
    }
}
