//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/16/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewController: UICollectionViewController {
    
    let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/6, height: (screenWidth/6)*1.5)
        layout.minimumInteritemSpacing = 0
        collectionView!.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MoviesCollectionViewCell
        let currentMovie = movies[indexPath.row]
        cell.thumbnail.adjustsImageWhenAncestorFocused = true
        cell.thumbnail.sd_setImage(with: URL(string: currentMovie.cover), placeholderImage: #imageLiteral(resourceName: "MissingArtworkMovies.png"), options: [], completed: nil)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentMovie = movies[indexPath.row]
        performSegue(withIdentifier: "showMoviesDetail", sender: self)
    }
}
