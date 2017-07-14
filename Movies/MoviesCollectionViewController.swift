//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/16/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"
var currentImage = UIImage()

class MoviesCollectionViewController: UICollectionViewController {
    
    let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
    var imageCache = [String:UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let currentMovie = movies[indexPath.row]
        let image = UIImage(named: "MissingArtworkMovies.png")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 35, y: 5, width: 250, height: (250)*1.5)
        imageView.isUserInteractionEnabled = true
        imageView.adjustsImageWhenAncestorFocused = true
        
        if let img = self.imageCache[currentMovie.cover]{
            imageView.image = img
            cell.addSubview(imageView)
        } else{
            URLSession.shared.dataTask(with: URL(string: currentMovie.cover)!, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.imageCache[currentMovie.cover] = image
                    if let currentCell = collectionView.cellForItem(at: indexPath){
                        imageView.image = image
                        currentCell.addSubview(imageView)
                    }
                })
                
            }).resume()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentMovie = movies[indexPath.row]
        currentImage = imageCache[movies[indexPath.row].cover]!
        performSegue(withIdentifier: "showMoviesDetail", sender: self)
    }
}
