//
//  String+Clear2Close.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/23/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

extension String {
    
    static func toDollars(_ amount: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        guard let priceString = currencyFormatter.string(from: NSNumber(value: amount)) else { return "" }
        return priceString
    }
}
