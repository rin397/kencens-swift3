//
//  ViewController.swift
//  instagramclone
//
//  Created by EricaSung on 2017/9/6.
//  Copyright © 2017年 Erica. All rights reserved.
//

//step1: 設計介面
//建立專案時, 選擇use coredata, 需要用它儲存使用者帳號密碼等資料
//介面:
//label: instagram
//textfield: account做為提示, 連接為outlet
//textfield: password做為提示, 連接為outlet
//button: login, 連接為outlet(改變形狀), action
//label: 還沒有帳號嗎？
//button: 建立新的帳號, 連接為action

//設layout constraints的時候要把margin勾勾取消, 手動調整按鈕位子

import UIKit
import CoreData

class ViewController: UIViewController {

//step6: 判斷登入帳號是否存在
    var isexist: Bool? //建立全域變量
//step10-1: 設定顏色與message為全域變量, 這樣就可以不斷調用infoview func
    let redcolor = UIColor.init(red: 255/255, green: 10/255, blue: 10/255, alpha: 1) //UIColor = 0~1間的數字
    let greencolor = UIColor.init(red: 10/255, green: 125/255, blue: 125/255, alpha: 1)
    var message = ""
    
//step2: 連接介面元件
    
    @IBOutlet weak var insertaccount: UITextField!
    @IBOutlet weak var insertpassword: UITextField!
    @IBOutlet weak var loginoutlet: UIButton!

    @IBAction func login(_ sender: Any) {
        
//step7: 登入 先判斷是否帳密都有輸入, 沒有的話提醒, 有的話再判斷是否有帳密, 沒有的話建議他新增, 有的話再判斷密碼對不對
//介面, 把密碼輸入框勾選secure text entry

//step7-1: 判斷帳密是否都有輸入進輸入框
        if insertaccount.text == "" || insertpassword.text == "" { //如果其中一個輸入框沒填
//step8-2: errorview顯示訊息
//step10-2: 改成全域
            message = "請輸入帳密喔"
            infoview(message: message, color: redcolor)
        
        } else {
//step7-4: 剛剛已經把輸入的帳密設成字典array, 現在來檢查
            isexist = false //先設成false, 之後才知道能不能改回來
            
            self.fetchuser(username: insertaccount.text!, completionHandler: { (isexist, userdictionary) in
                if isexist {
                    let pswdd = (userdictionary[0] as! NSDictionary)["password"]
                    if self.insertpassword.text == pswdd as! String {
                        //改成全域
                        self.message = "successful login"
                        self.infoview(message: self.message, color: self.greencolor)
                    } else {
                        //改成全域
                        self.message = "wrong password"
                        self.infoview(message: self.message, color: self.redcolor)
                        }
                    
                
                } else {
                    //改成全域
                    self.message = "請創建帳號喔"
                    self.infoview(message: self.message, color: self.redcolor)}
            })
            
        }
        
    }
    
    @IBAction func createaccount(_ sender: Any) {
        self.createalert() //按按鈕就執行功能
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//step3: 將login設為outlet後, 更改login按鈕的形狀
        loginoutlet.layer.cornerRadius = 50/2 //角角變圓形, 半徑為一半height
        loginoutlet.clipsToBounds = true //不在圓形的地方就切掉
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //因為鍵盤打開就不會收回去惹, 利用點擊螢幕其他地方來讓手機知道已經結束編輯惹 > 收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//step8: 把錯誤訊息顯示給使用者看
//step10: 想要顯示正確訊息, 把errorview改成infoview, 並加上變量讓底色可以跟著改變, 加上color
    func infoview(message: String, color: UIColor) {
    
        let infoviewheight = view.frame.height / 14 //view.frame = 整個螢幕
        let infoviewy = 0 - infoviewheight //因為希望他慢慢往下降, 所以先讓它放到螢幕上方, 底貼著螢幕頂端
        
        let infoview = UIView(frame: CGRect(x: 0, y: infoviewy, width: view.frame.width, height: infoviewheight)) //設立errorview一開始要放的位子
    

        infoview.backgroundColor = color
        
        view.addSubview(infoview) //在畫面上加上errorview

//step9: 把訊息放在errorview中
        
        let infolabel = UILabel()
        infolabel.frame.size.width = infoview.frame.width
        infolabel.frame.size.height = infoview.frame.height
        
        infolabel.text = message
        infolabel.textColor = UIColor.white
        infolabel.textAlignment = NSTextAlignment.center
        infolabel.font = UIFont(name: "HelveticaNeue", size: 14)
        
        infoview.addSubview(infolabel) //在errorview上面加label
        
        UIView.animate(withDuration: 0.2, animations: { infoview.frame.origin.y = 0 }) { (finished) in
        //幫errorview做動畫, 時間花0.2秒, 讓errorview的y跑到frame的0的位子, 完成就返回finished
            
            if finished {
                UIView.animate(withDuration: 0.2, delay: 2, options: UIViewAnimationOptions.curveLinear, animations: { infoview.frame.origin.y = infoviewy }) { (finished)
            //結束的動畫, 他會delay2秒, 如果返回finished, 就再跑結束的動畫,
                in
                
                    if finished { infoview.removeFromSuperview()
                                  infolabel.removeFromSuperview()
                    }
                //如果結束動畫返回finished, 就把errorview移除
            }}}}

//step6-1: 判斷新增帳號是否存在
    
//step7-2: 判斷登入帳號是否存在, 返回isexist外, 也返回dictionary, 這樣可以對密碼
    func fetchuser (username: String, completionHandler: @escaping (_ isexist: Bool,
        _ userdictionary: NSArray //7.array格式的字典, 對密碼用的
        ) -> ()) {
        
        
        var array = [NSDictionary]() //建立array的殼
    
        let appdelegate = UIApplication.shared.delegate as! AppDelegate //只要會用到coredata就要這兩句
        let context = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "UserDB") //設定資料提取格式與entity
        
        request.predicate = NSPredicate(format: "username = %@", username) //抓欄位username的string(%@)資料, 資料內容為輸入的username
        request.returnsObjectsAsFaults = false //如果沒資料也不要傳object格式, 要傳值
        
        do { let results = try context.fetch(request)
            
             if results.count > 0 { for result in results as! [NSManagedObject] {
                //results是NSFetchRequestResult的格式, 需要設成NSManagedObject才能提取
                
                if let userr = result.value(forKey: "username") as? String {
                    //result的user有資料就設為string, 並去對密碼
                   let pswdr = result.value(forKey: "password") as? String
                   let userdict = ["username": userr, "password": pswdr]
                    //result的password如果有資料就設為string
                    //把userr跟pswdr放到字典
                   array.append(userdict as NSDictionary)
                    //把字典加到剛做好的字典殼中
                    
                    isexist! = true //把isexist設為存在 
                }}}} catch { print("fetch error") } //如果有資料, 且有存成object, 就把isexist設為true
    
        completionHandler(isexist!, array as NSArray)} //返回兩個物件
    
    
    
//step5: 建立coredata
//在左邊的xcdatamodeld新增entity: UserDB (資料庫)
//在entity內新增attribute: username(string), password(string)
//在一開始import coredata

//step5-1: 建立功能將輸入的username, password放進entity
    func createuser (username: String, password: String) {

//step6-2: 把判斷帳號是否存在的功能放進來
        isexist = false
//step7-3: 因為剛剛改過fetchuser公式, 所以這裡要加上返回array才行
        fetchuser(username: username) { (isexist, array) in
            if isexist { print("the account is existed.") } else { //有帳號就說有, 沒有就創帳號

//step5-1: 建立功能將輸入的username, password放進entity
                
                let appdelegate = UIApplication.shared.delegate as! AppDelegate //把左邊appdelegate的權限調用到這裡
                let context = appdelegate.persistentContainer.viewContext //建立一個空間(container)存放資料
                
                let newuser = NSEntityDescription.insertNewObject(forEntityName: "UserDB", into: context) //在entity輸入新資料的功能
                
                newuser.setValue(username, forKey: "username")
                newuser.setValue(password, forKey: "password") //把剛剛輸入提示框的帳密放進entity
                
                do { try context.save() } catch { print("save failed") } //儲存剛剛放進空間的資料

            
            }
        }
        
        

    }
    
//step4: 建立提醒視窗：創建新帳號
    func createalert() {
    
//step4-1: 建立提醒視窗與按鈕
        let alert = UIAlertController(title: "創建帳號", message: "請輸入你的帳號與密碼", preferredStyle: .alert) //建立提醒視窗
        let createaction = UIAlertAction(title: "創建", style: .default) { (create) in
//step4-3: 設定判斷機制確定使用者有輸入帳號跟密碼
            if alert.textFields?[0].text == "" || alert.textFields?[1].text == "" { //如果其中一個輸入框沒填
                print("請輸入喔") } else {
                let user = alert.textFields![0]
                let pswd = alert.textFields![1] //把資料設為常量
//step5-2: 調用剛剛建立的功能
                self.createuser(username: user.text!, password: pswd.text!)}

        }

        let cancelaction = UIAlertAction(title: "取消", style: .cancel) { (cancel) in
            self.dismiss(animated: true, completion: nil)}

//step4-2: 建立提醒視窗的輸入框
        alert.addTextField { (textfield) in textfield.placeholder = "帳號" } //建立帳號輸入框
        alert.addTextField { (textfield) in textfield.placeholder = "密碼" //建立密碼輸入框
                                            textfield.isSecureTextEntry = true } //不顯示輸入的密碼
//step4-1: 按鈕的連動與視窗顯示
        alert.addAction(createaction)
        alert.addAction(cancelaction)
        
        self.present(alert, animated: true, completion: nil) //讓提醒視窗出現
        }

}

