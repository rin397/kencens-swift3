//
//  SecondViewController.swift
//  URL
//
//  Created by Wilson Hsieh on 2017/8/14.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var name = "wilson"
    var activeRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print("\(name) - \(activeRow)" )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
