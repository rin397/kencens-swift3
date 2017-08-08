//
//  ViewController.swift
//  是否質數
//
//  Created by mikewang on 2017/7/22.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBAction func testButton(_ sender: UIButton) {
        if inputField.text != "" {
            if let inputInt = Int(inputField.text!) {
                if inputInt > 0 {
                    var isPrime = true
                    if inputInt == 1 {
                        isPrime = false
                    }
                    
                    var i = 2
                    while i < inputInt {
                        if inputInt % i == 0 {
                            isPrime = false
                        }
                        i += 1
                    }
                    if isPrime {
                        result.text = "\(inputInt)是一個質數"
                    } else {
                        result.text = "\(inputInt)不是一個質數"
                    }
                } else {
                    result.text = "請輸入有效的正數!"
                }
            } else {
                result.text = "請輸入有效的正數!"
            }
        } else {
            result.text = "請輸入有效的正數!"
        }
        // 輸出結果後，清除文字輸入框
        inputField.text = ""
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

