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
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.frame = CGRect(x: 40, y: 0, width: screenWidth-80, height: screenHeight)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ((screenWidth-80)/5), height: (screenWidth/6)*1.5)
        layout.minimumInteritemSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .UIApplicationDidBecomeActive, object: nil)
    }

    func refreshData() {
        let url = URL(string: "http://timsvideos.x10host.com/videos.php")
        
        do {
            var counter = 0;
            let data = try NSData(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            let JSON = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
            if let dictionary = JSON as? [String: Any] {
                while(dictionary["\(counter)"] as? [String: Any] != nil){
                    let nestedDic = dictionary["\(counter)"] as? [String: Any]
                    let tmpMovie = movie(title : (nestedDic!["title"] as? String)!, cover : (nestedDic!["cover"] as? String)!, desc : (nestedDic!["desc"] as? String)!, link : (nestedDic!["link"] as? String)!, year: (nestedDic!["year"] as? String)!, index: counter)
                    movies.append(tmpMovie)
                    counter += 1
                }
            }
            self.collectionView?.reloadData()
        } catch let error as NSError {
            print("Error: \(error)")
            
            let alertController = UIAlertController(title: "No Internet Connection", message: "Seems like you are not connected to the internet. Check your connection.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            alertController.show(alertController, sender: self)
        }
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
