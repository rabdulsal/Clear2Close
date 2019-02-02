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
        case HardMoney = "Hard Money"
        case Private   = "Private"
        case Cash      = "Cash"
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
    var propertyType: C2CProperty.PropertyType {
        return self.property.propertyType
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
    
    init(storedDeal: C2CStoredDeal) {
        // Vars
        let propType       = storedDeal.propertyType ?? ""
        let propertyType   = C2CProperty.PropertyType(rawValue: propType) ?? .Rental
        let source         = storedDeal.fundingSource ?? ""
        // Stored Props
        self.purchasePrice = storedDeal.purchasePrice
        self.rehab         = storedDeal.rehab
        self.appraisalARV  = storedDeal.appraisalARV
        self.fundingSource = FundingSource(rawValue: source) ?? .HardMoney
        self.interestRate  = storedDeal.interestRate
        self.points        = storedDeal.points
        self.terms         = Int(storedDeal.terms)
        self.property      = C2CProperty(address: storedDeal.address ?? "", propertyType: propertyType)
    }
}
