//
//  ViewController.swift
//  URL
//
//  Created by Wilson Hsieh on 2017/8/14.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var webView: UIWebView!
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = URL(string: "https://stackoverflow.com")
//        
//        webView.loadRequest(URLRequest(url : url!))
        
        if  let url = URL(string: "https://stackoverflow.com") {
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                
                data , response , error in
                
                if error != nil {
                    
                    print(error)
                    
                }else{
                    
                    if  let unwrappedData = data {
                        let dataString = NSString(data:unwrappedData , encoding: String.Encoding.utf8.rawValue)
                        
//                        print(dataString)
                    }
                }
            }
            task.resume()
            
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "toSecond" {
            print("toSecond.....")
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.name = "Main"
            
        }else if segue.identifier == "tableViewSegue" {
            print("tableViewSegue.....")
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.activeRow = self.selectIndex
            
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "wilson\( indexPath.row)"
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath.row)
        self.selectIndex = indexPath.row
        
        performSegue(withIdentifier: "tableViewSegue", sender: nil)
    }
    




}

