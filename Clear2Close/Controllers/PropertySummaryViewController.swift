//
//  PropertyViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salaam on 1/16/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import UIKit

class PropertySummaryViewController: UIViewController {

    /*
     1. Displays comperehensive summary of property deal
     2. Decorated by C2CAnalysisService
    */
    
    @IBOutlet weak var summaryTableView : UITableView!
    @IBOutlet weak var propertyAddressLabel: UILabel!
    
    var deal: C2CDeal!
    var analysisService: C2CAnalysisService!
    var keyboardService: C2CKeyboardService!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardService.beginObservingKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.summaryTableView.dataSource = self
        self.propertyAddressLabel.text = self.deal.address
        self.analysisService = C2CAnalysisService.init(deal: self.deal, tableView: self.summaryTableView)
        self.keyboardService = C2CKeyboardService(self.summaryTableView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboardService.endObservingKeyboard()
    }

    @IBAction func pressedSaveButton(_ sender: Any) {
        // Set analysisService
        self.analysisService.saveDealtoCache()
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

extension PropertySummaryViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.analysisService.titleForSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.analysisService.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.analysisService.rowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.analysisService.cellForRow(indexPath: indexPath)
    }
}

private extension PropertySummaryViewController {
    
//    enum Identifiers : String {
//        case ViewCell = "ViewCell"
//        case EditCell = "EditCell"
//    }
}
