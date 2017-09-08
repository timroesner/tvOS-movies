//
//  SecondViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/13/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtField: UITextField!
    
    var filteredMovies = [movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let searchTxt = textField.text ?? ""
        filteredMovies.removeAll()
        for movie in movies {
            if(movie.title.lowercased().contains(searchTxt.lowercased())){
                filteredMovies.append(movie)
            }
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tempMovie = filteredMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        cell.thumbnail.adjustsImageWhenAncestorFocused = true
        cell.thumbnail.sd_setImage(with: URL(string: tempMovie.cover), placeholderImage: #imageLiteral(resourceName: "MissingArtworkMovies.png"), options: [], completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentMovie = filteredMovies[indexPath.row]
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "MoviesDetail") as! MoviesDetail
            self.present(vc, animated: true, completion: nil)
        }
    }
}

