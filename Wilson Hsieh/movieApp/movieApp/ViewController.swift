//
//  ViewController.swift
//  movieApp
//
//  Created by Wilson Hsieh on 2017/8/15.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movie?.title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

