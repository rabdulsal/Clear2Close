//
//  Deal.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

class C2CDeal {
    
    enum FundingSource : String {
        case HardMoney = "hardmoney"
        case Private   = "private"
        case Cash      = "cash"
    }
    
    var property: C2CProperty
    var purchasePrice: Double
    var rehab: Double
    var appraisalARV: Double
    var fundingSource: FundingSource
    var interestRate: Double
    var points: Double
    var terms: Int
    var address: String {
        return self.property.address
    }
    
    init(
        property: C2CProperty,
        purchasePrice: Double,
        rehab: Double,
        appraisal: Double,
        funding: FundingSource,
        interest: Double,
        points: Double,
        terms: Int)
    {
        self.property      = property
        self.purchasePrice = purchasePrice
        self.rehab         = rehab
        self.appraisalARV  = appraisal
        self.fundingSource = funding
        self.interestRate  = interest
        self.points        = points
        self.terms         = terms
    }
}
