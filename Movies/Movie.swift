//
//  Movie.swift
//  Movies
//
//  Created by Tim Roesner on 12/15/17.
//  Copyright © 2017 Tim Roesner. All rights reserved.
//

import Foundation

struct Movie {
    
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
