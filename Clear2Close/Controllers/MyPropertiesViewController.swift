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
    
    var searchController: UISearchController!
    private var filteredDeals = Array<C2CDeal>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPropertiesTableView.dataSource = self
        self.myPropertiesTableView.delegate = self
        C2CDealsService.loadDealsData()
        
        // SearchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
        return self.searchInProgress ? 1 : C2CDealsService.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.searchInProgress ? nil : C2CDealsService.getSectionTitle(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchInProgress ? self.filteredDeals.count : C2CDealsService.numberOfDealsForSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = self.myPropertiesTableView.dequeueReusableCell(withIdentifier: Identifiers.DealsID.rawValue, for: indexPath)
        let deal: C2CDeal
        if self.searchInProgress {
            deal = self.filteredDeals[indexPath.row]
        } else {
             guard let _deal = C2CDealsService.getDealForIndexPath(indexPath) else { return UITableViewCell() }
            deal = _deal
        }
        cell.textLabel?.text = deal.address
        
        return cell
    }
}

extension MyPropertiesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let deal: C2CDeal
        if self.searchInProgress {
            deal = self.filteredDeals[indexPath.row]
        } else {
            guard let _deal = C2CDealsService.getDealForIndexPath(indexPath) else { return }
            deal = _deal
        }
        self.performSegue(withIdentifier: Identifiers.SegueID.rawValue, sender: deal)
    }
}

// MARK: - SearchController
extension MyPropertiesViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContents(of: searchController.searchBar.text!)
    }
}

private extension MyPropertiesViewController {
    
    enum Identifiers : String {
        case SegueID = "PropSummaryID"
        case DealsID = "DealsCell"
    }
    
    var searchInProgress: Bool {
        return searchController.isActive && searchController.searchBar.text?.isEmpty == false
    }
    
    func filterContents(of searchText: String) {
        self.filteredDeals = C2CDealsService.allDeals.filter { $0.address.lowercased().contains(searchText.lowercased()) }
        self.myPropertiesTableView.reloadData()
    }
}
