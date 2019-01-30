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
        super.viewDidLoad()
        self.myPropertiesTableView.dataSource = self
        self.myPropertiesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myPropertiesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == Identifiers.SegueID.rawValue {
            let destination = segue.destination as! PropertySummaryViewController
            destination.deal = sender as? C2CDeal
        }
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
        guard let deal = C2CDealsService.getDealForIndexPath(indexPath) else { return UITableViewCell() }
        let cell = self.myPropertiesTableView.dequeueReusableCell(withIdentifier: Identifiers.DealsID.rawValue, for: indexPath)
        cell.textLabel?.text = deal.address
        
        return cell
    }
}

extension MyPropertiesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let deal = C2CDealsService.getDealForIndexPath(indexPath)
        self.performSegue(withIdentifier: Identifiers.SegueID.rawValue, sender: deal)
    }
}

private extension MyPropertiesViewController {
    
    enum Identifiers : String {
        case SegueID = "PropSummaryID"
        case DealsID = "DealsCell"
    }
}
