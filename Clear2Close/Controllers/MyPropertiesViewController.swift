//
//  MyPropertiesViewController.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/21/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class MyPropertiesViewController : UIViewController {
    /*
     --- BIG NOTES ---
     1. Must conform to SearchBar delegate
     2. Needs Section headers for 'Rentals' 'Flips' 'Other', that toggle mini-table views when header is tapped
     3. Needs Empty Screen when there are no properties created
    */
    
    @IBOutlet weak var myPropertiesTableView: UITableView!
    
    override func viewDidLoad() {
        self.myPropertiesTableView.dataSource = self
    }
    
}

extension MyPropertiesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return C2CDealsService.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return C2CDealsService.getSectionTitle(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return C2CDealsService.numberOfDealsForSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
