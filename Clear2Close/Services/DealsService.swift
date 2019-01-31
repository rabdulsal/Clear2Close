//
//  DealsService.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation

/*
 1. Service will manage arrays of C2CDeals, bucket them and decorate MyPropertiesVC
 2. Will manage storage and retrieval of Deals objects from CoreData
 */

class GroupedDeal {
    var title: String; var dealsGroup = Array<C2CDeal>()
    
    init(_ deal: C2CDeal) {
        self.title = deal.propertyType.rawValue; self.dealsGroup.append(deal)
    }
}

class C2CDealsService {
    
    static var allDeals = Array<C2CDeal>()
    
    static func saveDealToCache(_ deal: C2CDeal) {
        self.allDeals.append(deal)
        // Update Deals Hash
        self.updateDealsHash(with: deal)
    }
    
    // DataSource Management for TableView
    
    static var numberOfSections: Int {
        return self.dealsTitleHash.count
    }
    
    static func getSectionTitle(_ section: Int) -> String? {
        return self.getGroupedDeal(for: section)?.title
    }
    
    static func numberOfDealsForSection(_ section: Int) -> Int {
        guard let dealsGroup = self.getGroupedDeal(for: section) else { return 0 }
        let deals = dealsGroup.dealsGroup
        return deals.count
    }
    
    static func getDealForIndexPath(_ indexPath: IndexPath) -> C2CDeal? {
        guard let groupedDeals = self.getGroupedDeal(for: indexPath.section) else { return nil }
        return groupedDeals.dealsGroup[indexPath.row]
    }
}

private extension C2CDealsService {
    
    static var dealsHash = Dictionary<Int,GroupedDeal>()
    
    static var dealsTitleHash = Dictionary<String,Int>()
    
    static func updateDealsHash(with deal: C2CDeal) {
        let propType = deal.propertyType.rawValue
        if
            let dealInt = dealsTitleHash[propType],
            let dealsGroup = dealsHash[dealInt]
        {
            dealsGroup.dealsGroup.append(deal)
        } else {
            let newHashCount = dealsTitleHash.count
            dealsTitleHash[propType] = newHashCount
            let dealsGroup = GroupedDeal(deal)
            self.dealsHash[newHashCount] = dealsGroup
        }
    }
    
    static func getGroupedDeal(for section: Int) -> GroupedDeal? {
        guard let dealsGroup = self.dealsHash[section] else { return nil }
        return dealsGroup
    }
    
    
}
