//
//  MovieCellTableViewCell.swift
//  movieApp
//
//  Created by Wilson Hsieh on 2017/8/16.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgData: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var s1: UIImageView!
    
    @IBOutlet weak var s2: UIImageView!
    
    @IBOutlet weak var s3: UIImageView!
    
    @IBOutlet weak var s4: UIImageView!
    
    @IBOutlet weak var s5: UIImageView!
    
    var starArrary:[UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starArrary = []

        self.starArrary.append( s1)
        self.starArrary.append( s2)
        self.starArrary.append( s3)
        self.starArrary.append( s4)
        self.starArrary.append( s5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setStarValue(starValue:Float) {
        
        var allStar:Int = Int(starValue / 1)
        
        let halfStar:Float = starValue - Float(allStar)
        for index in (0...allStar-1){
            var item =  self.starArrary[index] as UIImageView
            var image : UIImage = UIImage(named:"all.jpg")!
            item.image = image
        }
        
        if halfStar != 0 {
            var item =  self.starArrary[allStar] as UIImageView
            var image : UIImage = UIImage(named:"helf.jpg")!
            item.image = image
        }
        
        
    }
    
}
