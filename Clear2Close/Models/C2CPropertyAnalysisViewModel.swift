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
    
    func makeDealHash() {
        
    }
    
    func cellContentForRow(row: Int) -> DealViewModel {
        guard let title = AnalysisHash(rawValue: row) else { return DealViewModel(title: "", description: "") }
        switch title {
        case .Funding:
            return DealViewModel(title: self.fundingTitle, description: self.deal.fundingSource.rawValue)
        case .PurchasePrice:
            return DealViewModel(title: self.purchaseTitle, description: String(self.deal.purchasePrice))
        case .Rehab:
            return DealViewModel(title: self.rehabTitle, description: String(self.deal.rehab))
        case .AppraisalARV:
            return DealViewModel(title: self.interestTitle, description: String(self.deal.interestRate))
        case .Interest:
            return DealViewModel(title: self.interestTitle, description: String(self.deal.interestRate))
        case .Points:
            return DealViewModel(title: self.pointsTitle, description: String(self.deal.points))
        case .Terms:
            return DealViewModel(title: self.termsTitle, description: String(self.deal.terms))
        }
    }
    
}
