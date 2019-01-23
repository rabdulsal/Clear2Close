//
//  String+Clear2Close.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/23/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

extension String {
    
    static func rounded(_ amount: Double) -> String {
        return String(format: "%.2f", amount)
    }
}
