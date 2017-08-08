//
//  ViewController.swift
//  guessFingerApp
//
//  Created by mikewang on 2017/7/22.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBAction func guessButton(_ sender: UIButton) {
        let randomNumber = String(arc4random_uniform(6))
        
        if textField.text == randomNumber {
            result.text = "您猜對了!"
        } else {
            result.text = "抱歉，您猜錯了，我伸出了\(randomNumber)根手指"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

