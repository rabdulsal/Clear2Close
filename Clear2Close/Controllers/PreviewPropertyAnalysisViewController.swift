//
//  PreviewPropertyAnalysisViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class PreviewPropertyAnalysisViewController : UIViewController {
    
    /*
     Preview Rental Analysis info in checkered TableView
     */
    
    
    
    @IBOutlet weak var propertyAddressLabel : UILabel!
    @IBOutlet weak var propertyTableView : UITableView!
    
    var property: C2CProperty!
    var dealViewModel: C2CPropertyAnalysisModel!
    
    override func viewDidLoad() {
        self.title = "Preview Analysis"
        self.propertyAddressLabel.text = self.property.address
        self.propertyTableView.delegate = self
        self.propertyTableView.dataSource = self
    }
    
    @IBAction func pressedContinueButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: Identifiers.SummarySegue.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PropertySummaryViewController
        destination.deal = self.dealViewModel.deal
    }
    
}

extension PreviewPropertyAnalysisViewController : UITableViewDelegate {
    
    
}

extension PreviewPropertyAnalysisViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dealViewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.propertyTableView.dequeueReusableCell(withIdentifier: Identifiers.PreviewCell.rawValue, for: indexPath) as! PreviewAnalysisCell
        cell.configure(viewModel: self.dealViewModel.cellContentForRow(row: indexPath.row))
        return cell
    }
}

extension PreviewPropertyAnalysisViewController {
    
    enum Identifiers : String {
        case SummarySegue = "SummaryID"
        case PreviewCell = "PreviewCell"
    }
}
