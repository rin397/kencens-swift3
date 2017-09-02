//
//  movie.swift
//  線上電影
//
//  Created by EricaSung on 2017/8/29.
//  Copyright © 2017年 Erica. All rights reserved.
//

import UIKit

class movie: NSObject {

    var title: String?
    var date: String?
    var id: Int?
    var vote_count: Int?
    var vote_average: Float?
    var poster: String?

init(title: String, date: String, id: Int, vote_count: Int, vote_average: Float, poster: String){
    self.title = title
    self.date = date
    self.id = id
    self.vote_count = vote_count
    self.vote_average = vote_average
    self.poster = poster
    }
}
//初始化 把外面的值賦進NSObject的機會 //self = movie
