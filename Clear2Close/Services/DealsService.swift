//
//  DealsService.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
        self.storeDealInCache(deal)
        self.loadDealsData()
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
    
    static func storeDealInCache(_ deal: C2CDeal) {
        guard let appDelegate = self.appDelegate, let managedContext = self.managedContext else { return }
        let storedDeal = C2CStoredDeal(context: managedContext)
        storedDeal.address       = deal.address
        storedDeal.appraisalARV  = deal.appraisalARV
        storedDeal.fundingSource = deal.fundingSource.rawValue
        storedDeal.interestRate  = deal.interestRate
        storedDeal.points        = deal.points
        storedDeal.propertyType  = deal.propertyType.rawValue
        storedDeal.purchasePrice = deal.purchasePrice
        storedDeal.rehab         = deal.rehab
        storedDeal.terms         = Double(deal.terms)
        appDelegate.saveContext()
    }
    
    static func removeDealFromCache(_ storedDeal: C2CStoredDeal) {
        guard let appDelegate = self.appDelegate, let managedContext = self.managedContext else {
//            completion(UpdateError)
            return
        }
        managedContext.delete(storedDeal)
        appDelegate.saveContext()
    }
    
    static func loadDealsData() {
        self.dealsHash.removeAll()
        self.dealsTitleHash.removeAll()
        self.fetchAndOrganizeStoredDealsInHash()
    }
}

private extension C2CDealsService {
    
    static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate ?? nil
    }
    
    static var managedContext: NSManagedObjectContext? {
        guard let appDelegate = self.appDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
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
    
    static func getAllStoredDeals() -> Array<C2CStoredDeal> {
        guard let managedContext = self.managedContext else { return [] }
        
        do {
            return try managedContext.fetch(C2CStoredDeal.fetchRequest())
        } catch let error as NSError {
            // TODO: Add Error handling to completion
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func fetchAndOrganizeStoredDealsInHash() {
        let storedDeals = self.getAllStoredDeals()
        for storedDeal in storedDeals {
            let deal = C2CDeal(storedDeal: storedDeal)
            self.allDeals.append(deal)
            self.updateDealsHash(with: deal)
        }
    }
    
    /**
     Create a FavoritesContact groupPosition for FavoritesGroup using a groupTitle
     - parameter groupTitle: Title of the FavoritesGroup to create
     */
    static func generateStoredDealGroupPosition(groupTitle: String) -> Double {
        guard
            let sectionIdx = dealsTitleHash[groupTitle],
            let group = self.dealsHash[sectionIdx] else { return 0.0 }
        return Double(group.dealsGroup.count)
    }
    
    /**
     Create a FavoritesContact groupPositionSection for FavoritesGroup using a groupTitle
     - parameter groupTitle: Title of the FavoritesGroup used to derive a section index
     */
    static func generateStoredDealGroupSectionIndex(groupTitle: String) -> Double {
        guard let sectionIdx = self.dealsTitleHash[groupTitle] else { return Double(self.dealsTitleHash.count) }
        return Double(sectionIdx)
    }
}
