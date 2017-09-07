//
//  SecondViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/13/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit

class SearchViewController: UISearchController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.obscuresBackgroundDuringPresentation = false
    }
    
    override func viewDidLayoutSubviews() {
        self.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        cell.thumbnail.image = #imageLiteral(resourceName: "MissingArtworkMovies.png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Success")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("Update")
    }
}

