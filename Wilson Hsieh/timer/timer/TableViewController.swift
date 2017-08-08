//
//  TableViewController.swift
//  timer
//
//  Created by Wilson Hsieh on 2017/8/8.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

protocol TypeValueUpdateDelegate {
    func userDidEnterDataInvoke(data: Int, type: String)
}

class TableViewController: UITableViewController  {
    
    var timerTaskDic : [String: Int]!
    
    var timerKey:[String]!
    
    var delegate: TypeValueUpdateDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerTaskDic = defaults.object(forKey: "timerTask") as? [String: Int] ?? [String: Int]()
        timerKey = Array(timerTaskDic.keys)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timerTaskDic.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let type = timerKey[indexPath.row]
        let sec:Int = timerTaskDic[type]!
        cell.typeLabel.text = type
        cell.typeText.text = String(sec)
        cell.delegate = self
        
        return cell
    }
    
}

extension TableViewController:DataSentDelegate {
    
    func userDidEnterData(data: Int , type: String) {
        
        if delegate != nil {
            delegate?.userDidEnterDataInvoke(data: data ,type: type)
        }
    }
}
