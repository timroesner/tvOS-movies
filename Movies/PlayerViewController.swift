//
//  PlayerViewController.swift
//  Movies
//
//  Created by Tim Roesner on 2/17/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    
    func playVideo() {
        player = AVPlayer(url: URL(string: currentMovie!.link)!)
        player?.play()
    }
    
}
