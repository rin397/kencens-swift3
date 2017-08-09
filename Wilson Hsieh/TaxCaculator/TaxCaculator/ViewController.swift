//
//  ViewController.swift
//  TaxCaculator
//
//  Created by Wilson Hsieh on 2017/8/9.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var taxFieldInput: UITextField!
    
    @IBOutlet weak var taxRateList: UISegmentedControl!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func caculateAction(_ sender: Any) {
        
        var result:String!
        
        if self.taxFieldInput.text != nil && !(self.taxFieldInput.text?.isEmpty)! {
            let inputValue = self.taxFieldInput.text!
            let index = taxRateList.selectedSegmentIndex
            var ratio:Float!
            switch index {
            case 0:
                print("3%")
                ratio = 0.03
            case 1:
                print("5%")
                ratio = 0.05
            case 2:
                print("8%")
                ratio = 0.08
            case 3:
                print("10%")
                ratio = 0.1
            default:
                print("error")
            }
            var price = Int(inputValue)
            var tax:Float =  Float(price!)*ratio
            result = "Tax value is \( tax )."
        }else{
            result = "please enter price."

        }
        self.resultLabel.text = result
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

