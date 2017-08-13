//
//  TableViewCell.swift
//  timer
//
//  Created by Wilson Hsieh on 2017/8/8.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

protocol DataSentDelegate {
    func userDidEnterData(data: Int, type: String)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var typeText: UITextField!
    
    var delegate: DataSentDelegate? = nil

    var timerTaskDic : [String: Int]!

    
    @IBAction func valueUpdate(_ sender: Any) {
        print("invoke")
        if delegate != nil {
            if typeLabel.text != nil {
                let oriSec =  timerTaskDic[typeLabel.text!]
                let newSec = Int(typeText.text!)
                if ( oriSec != newSec ){
                    
                    print(oriSec != newSec)
                    delegate?.userDidEnterData(data: newSec!,type: typeLabel.text!)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
