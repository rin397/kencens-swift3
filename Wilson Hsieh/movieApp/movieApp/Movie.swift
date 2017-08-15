//
//  Movie.swift
//  movieApp
//
//  Created by Wilson Hsieh on 2017/8/15.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var title:String?
    var releaseDate:String?
    var id:Int?
    var postPath:String?
    var overview:String?
    var voteCount:Int?
    
     init(title:String , releaseDate:String, id:Int ,postPath:String , overview:String , voteCount:Int ) {
        self.title = title
        self.releaseDate = releaseDate
        self.id = id
        self.postPath = postPath
        self.overview = overview
        self.voteCount = voteCount
    }
}
