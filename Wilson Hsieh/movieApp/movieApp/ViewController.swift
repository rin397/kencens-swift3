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
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var overview: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = movie?.dataImg
        imgView.autoresizingMask  = [.flexibleWidth, .flexibleHeight]
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        self.title = movie?.title
        self.overview.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.overview.text = movie?.overview
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

