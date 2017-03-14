//
//  AppDelegate.swift
//  Movies
//
//  Created by Tim Roesner on 2/13/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import UIKit

var movies:[movie] = []
var covers:[UIImage] = []
var currentMovie:movie? = nil

class movie {
    let title : String
    let cover : String
    let desc : String
    let link : String
    let year : String
    let index : Int
    
    init(title : String, cover : String, desc : String, link : String, year: String, index: Int) {
        self.title = title
        self.cover = cover
        self.desc = desc
        self.link = link
        self.year = year
        self.index = index
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
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
        } catch let error as NSError {
            print("Error: \(error)")
            
            let alertController = UIAlertController(title: "No Internet Connection", message: "Seems like you are not connected to the internet. Check your connection.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            alertController.show(alertController, sender: self)
        }
        
        for movie in movies{
            let imgURL = URL(string: movie.cover)!
            let data = NSData(contentsOf: imgURL)
            let image = UIImage(data: data as! Data)
            covers.append(image!)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
                }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

