//
//  FirstViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/13/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

var playerController = AVPlayerViewController()

class MoviesDetail: UIViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var descLbl:UILabel!
    @IBOutlet var yearLbl:UILabel!
    @IBOutlet var cover:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lblTitle.text = currentMovie!.title
        descLbl.text = currentMovie!.desc
        yearLbl.text = currentMovie!.year
        cover.sd_setImage(with: URL(string: currentMovie!.cover), placeholderImage: #imageLiteral(resourceName: "MissingArtworkMovies.png"), options: [], completed: nil)
    }
    
    @IBAction func playBtn (_ Sender: UIButton) {
        let playerVC = PlayerViewController()
        self.present(playerVC, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

