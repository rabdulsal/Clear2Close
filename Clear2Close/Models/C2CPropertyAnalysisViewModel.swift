//
//  C2CPropertyAnalysisViewModel.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/23/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

class C2CPropertyAnalysisModel {
    struct DealViewModel {
        var title: String
        var description: String
        
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
    
    /*
     ViewModel for PropertyAnalysis preview
    */
    
    let fundingTitle = "Funding"
    let purchaseTitle = "Purchase Price"
    let rehabTitle = "Rehab"
    let appraisalTitle = "Appraisal ARV"
    let interestTitle = "Interest Rate"
    let pointsTitle = "Points"
    let termsTitle = "Terms"
    
    private enum AnalysisHash : Int {
        case Funding
        case PurchasePrice
        case Rehab
        case AppraisalARV
        case Interest
        case Points
        case Terms
        
        static var count : Int {
            return Terms.rawValue + 1
        }
    }
    
    var deal: C2CDeal
    var rowCount : Int {
        return AnalysisHash.count
    }
    
    init(deal: C2CDeal) {
        self.deal = deal
    }
    
    func cellContentForRow(row: Int) -> DealViewModel {
        guard let title = AnalysisHash(rawValue: row) else { return DealViewModel(title: "", description: "") }
        
        let purchase = String.toDollars(self.deal.purchasePrice)
        let rehab = String.toDollars(self.deal.rehab)
        let appraisal = String.toDollars(self.deal.appraisalARV)
        let interest = "\(String(self.deal.interestRate))%"
        let points = "\(String(self.deal.points))%"
        let terms = "\(String(self.deal.terms)) Months"
        
        switch title {
        case .Funding:
            return DealViewModel(title: self.fundingTitle, description: self.deal.fundingSource.rawValue)
        case .PurchasePrice:
            return DealViewModel(title: self.purchaseTitle, description: purchase)
        case .Rehab:
            return DealViewModel(title: self.rehabTitle, description: rehab)
        case .AppraisalARV:
            return DealViewModel(title: self.appraisalTitle, description: appraisal)
        case .Interest:
            return DealViewModel(title: self.interestTitle, description: interest)
        case .Points:
            return DealViewModel(title: self.pointsTitle, description: points)
        case .Terms:
            return DealViewModel(title: self.termsTitle, description: terms)
        }
    }
    
}
