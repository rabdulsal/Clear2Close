//
//  AnalysisService.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit



class C2CAnalysisService {
    
    /*k
     Serves as ViewModel for PropertySummaryViewController
    */
    
    struct SummaryRowViewModel {
        
        var sectionTitle: String
        var rowData = Array<SummaryRowData>()
        
        init(title: String) {
            self.sectionTitle = title
        }
    }
    
    struct SummaryRowData {
        enum RowType : String {
            case Edit, View
        }
        
        var rowType: RowType
        var rowLabel: String
        var rowValue: String
        
        init(type: RowType, label: String, value: String) {
            self.rowLabel = label
            self.rowValue = value
            self.rowType = type
        }
    }
    
    enum SectionIndexes : Int {
        case HardMoney
        case Taxes
        case Insurance
        case Closing
        
        enum Titles : String {
            case Money = "Hard Money"
            case Taxes = "Taxes"
            case Insurance = "Insurance and Fees"
            case Closing = "Closing"
        }
        static var count : Int {
            return SectionIndexes.Closing.rawValue + 1
        }
    }
    
    var summaryRowHash = Dictionary<Int,SummaryRowViewModel>()
    
    var deal: C2CDeal
    var tableView: UITableView
    
    // Hard Money
    
    var hmLTV : String {
        
        return "65%"
    }
    
    var hmPurchaseCover : String {
        return String.toDollars(113750)
    }
    
    var hmPoints : String {
        return String.toDollars(7150)
    }
    
    var hmFees : String {
        return String.toDollars(28600)
    }
    
    var hmMonthlyInterest : String {
        return String.toDollars(1787.50)
    }
    
    var hmDailyInterest : String {
        return String.toDollars(59.58)
    }
    
    var hmYearlyInterest : String {
        return String.toDollars(21450)
    }
    
    // Taxes
    
    var transferTaxPercent : String {
        return "2.139"
    }
    
    var transferTaxDollar : String {
        return String.toDollars(2139)
    }
    
    var propertyTaxes : String {
        return String.toDollars(1000)
    }
    
    // Insurance
    
    var titleInsurance : String {
        return String.toDollars(1500)
    }
    
    var propertyInsurance : String {
        return String.toDollars(2000)
    }
    
    var wholesaleFee : String {
        return String.toDollars(0)
    }
    
    var firstDraw : String {
        return String.toDollars(0)
    }
    
    // Closing
    
    var cashRequired : String {
        return String.toDollars(-13750)
    }
    
    var moneyToTable : String {
        return String.toDollars(-2961)
    }
    
    var allInCash : String {
        return String.toDollars(199239)
    }
    
    var expectedSalePrice : String {
        return String.toDollars(300000)
    }
    
    var closingTaxCommission : String {
        return String.toDollars(24417)
    }
    
    var profit : String {
        return String.toDollars(94495)
    }
    
    init(deal: C2CDeal, tableView: UITableView) {
        self.deal = deal
        self.tableView = tableView
        
        self.makeViewModelData()
    }
    
    // TableView UI
    
    var sectionCount : Int {
        return SectionIndexes.count
    }
    
    func titleForSection(_ section: Int) -> String {
        guard let viewModel = self.summaryRowHash[section] else { return "" }
        return viewModel.sectionTitle
    }
    
    func rowsInSection(section: Int) -> Int {
        let rows = self.getRowDataForSection(section)
        return rows.count
    }
    
    func cellForRow(indexPath: IndexPath) -> UITableViewCell {
        
        /*
         1. Get View Model from hash using section
         2. Get VM data row from indexPath
         3. Switch on row by type, configure, and return appropriate cell type
         */
        
        let dataArray = self.getRowDataForSection(indexPath.section)
        let rowData = dataArray[indexPath.row]
        switch rowData.rowType {
        case .Edit:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.EditCell.rawValue, for: indexPath) as? PropertySummaryEditCell else { return UITableViewCell() }
            cell.configure(rowContent: rowData)
            return cell
        case .View:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.ViewCell.rawValue, for: indexPath) as? PropertySummaryViewCell else { return UITableViewCell() }
            cell.configure(rowContent: rowData)
            return cell
        }
    }
    
    func saveDealtoCache() {
        // Save to CoreData
        
        C2CDealsService.saveDealToCache(self.deal)
    }
}

private extension C2CAnalysisService {
    
    enum CellIdentifiers : String {
        case ViewCell = "ViewCell"
        case EditCell = "EditCell"
    }
    
    func makeViewModelData() {
        let start = SectionIndexes.HardMoney.rawValue
        let end = SectionIndexes.Closing.rawValue
        
        for i in start...end {
            guard let section = SectionIndexes(rawValue: i) else { return }
            switch section {
                /*
                 For each section:
                 1. Make row VM
                 2. Update row VM array data
                 3. Update row hash
                 
                */
            case .HardMoney:
                // 1. Make Row VM
                
                var hmModel = SummaryRowViewModel(title: SectionIndexes.Titles.Money.rawValue)
                
                // 2. Make Row Data -- Move to separate model?
                // LTV
                let ltvRow = SummaryRowData(type: .Edit, label: "HM LTV", value: self.hmLTV)
                hmModel.rowData.append(ltvRow)
                // Purchase Cover
                let purchaseRow = SummaryRowData(type: .View, label: "HM Cover for Purchase", value: self.hmPurchaseCover)
                hmModel.rowData.append(purchaseRow)
                // Points
                let pointsRow = SummaryRowData(type: .View, label: "HM Points $ at 4%", value: self.hmPoints)
                hmModel.rowData.append(pointsRow)
                // Fees
                let feesRow = SummaryRowData(type: .View, label: "Total HM Fees", value: self.hmFees)
                hmModel.rowData.append(feesRow)
                // Monthly Int
                let monthlyInt = SummaryRowData(type: .View, label: "HM Monthly Interest", value: self.hmMonthlyInterest)
                hmModel.rowData.append(monthlyInt)
                // Daily Int
                let dailyInt = SummaryRowData(type: .View, label: "HM Daily Interest", value: self.hmDailyInterest)
                hmModel.rowData.append(dailyInt)
                // Yearly Int
                let yearlyInt = SummaryRowData(type: .View, label: "HM 12 Month Interest at 12%", value: self.hmYearlyInterest)
                hmModel.rowData.append(yearlyInt)
                
                // 3. Update Hash
                self.summaryRowHash[SectionIndexes.HardMoney.rawValue] = hmModel
            case .Taxes:
                //1. Make row VM
                var taxesVM = SummaryRowViewModel(title: SectionIndexes.Titles.Taxes.rawValue)
                //2. Update row VM array data
                let transferTaxPercent = SummaryRowData(type: .Edit, label: "Transfer Tax % (PA)", value: self.transferTaxPercent)
                taxesVM.rowData.append(transferTaxPercent)
                
                let transferTaxDollar = SummaryRowData(type: .View, label: "Transfer Tax $", value: self.transferTaxDollar)
                taxesVM.rowData.append(transferTaxDollar)
                
                let propertyTax = SummaryRowData(type: .View, label: "Property Taxes", value: self.propertyTaxes)
                taxesVM.rowData.append(propertyTax)
                //3. Update row hash
                self.summaryRowHash[SectionIndexes.Taxes.rawValue] = taxesVM
            case .Insurance:
                var insuranceVM = SummaryRowViewModel(title: SectionIndexes.Titles.Insurance.rawValue)
                
                let titleInsurance = SummaryRowData(type: .Edit, label: "Title Insurance", value: self.titleInsurance)
                insuranceVM.rowData.append(titleInsurance)
                
                let propertyInsurance = SummaryRowData(type: .Edit, label: "Property Insurance", value: self.propertyInsurance)
                insuranceVM.rowData.append(propertyInsurance)
                
                let wholesaleFee = SummaryRowData(type: .Edit, label: "Wholesale Fee", value: self.wholesaleFee)
                insuranceVM.rowData.append(wholesaleFee)
                
                let firstDraw = SummaryRowData(type: .Edit, label: "First Draw", value: self.firstDraw)
                insuranceVM.rowData.append(firstDraw)
                
                self.summaryRowHash[SectionIndexes.Insurance.rawValue] = insuranceVM
            case .Closing:
                var closingVM = SummaryRowViewModel(title: SectionIndexes.Titles.Closing.rawValue)
                
                let cashRequired = SummaryRowData(type: .View, label: "Cash Required", value: self.cashRequired)
                closingVM.rowData.append(cashRequired)
                
                let moneyOnTable = SummaryRowData(type: .View, label: "Money to the Table", value: self.moneyToTable)
                closingVM.rowData.append(moneyOnTable)
                
                let allIn = SummaryRowData(type: .View, label: "All in $", value: self.allInCash)
                closingVM.rowData.append(allIn)
                
                let expectedSale = SummaryRowData(type: .View, label: "Expected Sale Price", value: self.expectedSalePrice)
                closingVM.rowData.append(expectedSale)
                
                let closingCommision = SummaryRowData(type: .View, label: "Closing/Commision/Tax", value: self.closingTaxCommission)
                closingVM.rowData.append(closingCommision)
                
                let profit = SummaryRowData(type: .View, label: "Profit", value: self.profit)
                closingVM.rowData.append(profit)
                
                self.summaryRowHash[SectionIndexes.Closing.rawValue] = closingVM
                
            }
        }
    }
    
    func getRowDataForSection(_ section: Int) -> Array<SummaryRowData> {
        guard let viewModel = self.summaryRowHash[section] else { return [] }
        return viewModel.rowData
    }
}
