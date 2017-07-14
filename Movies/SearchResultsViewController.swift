//
//  SearchResultsViewController.swift
//  Movies
//
//  Created by Tim Roesner on 7/13/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit

class SearchResultsViewController: UISearchController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultsUpdater = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
    
}
