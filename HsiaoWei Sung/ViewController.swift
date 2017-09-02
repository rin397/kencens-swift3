//
//  ViewController.swift
//  線上電影
//
//  Created by EricaSung on 2017/8/28.
//  Copyright © 2017年 Erica. All rights reserved.
//
//介面：
//新增table view controller 他同時結合table view跟view controller
//讓第一頁是table view controller
//new > file > new > cocoa touch > uitableviewcontroller
//因為已經是table view controller 所以不用再連uitableview datasource, uitableview delegate
//放列數,資料內容,
//連到tableviewcontroller

//把tableview的style改成subtitle就可以裝小欄位的資料
//在style下面的image放圖片, 抓不到圖片時就可以顯示這個image, 不會醜

//info.plist可以open as sourcecode這樣 把相關的地方複製起來做使用 只要改網址就好惹

//在tableviewcontroller那邊抓電影的API資料

//new > file > new > cocoa touch > 新增NSobject裝json的資料




//介面：
//連接tableviewcontroller的cell到viewcontroller
//幫segue的identifier命名
//建立function 利用prepare for segue的segue.definition把viewcontroller定義成 常量的viewcontroller
//就可以調用viewcontroller的資料惹


//介面：
//現在可以點選tableviewcontroller到下一頁 但不能回來
//所以點選tableviewcontroller上面那排 跑出黃色點點後 點選他 > editor > embed in > navigation controller
//這樣在main.storyboard會多出一頁 但在模擬時只會在view controller上面多一個back讓他返回

//把viewcontroller的webview連到公式區設為outlet 讓他去讀網頁

//介面：
//因為圖片太小張太醜惹
//去tableview那邊 點右邊上面的尺規 把高度改成150
//然後在tavleviewcontroller的tableview func下面建一個resize func


import UIKit

class ViewController: UIViewController {
    
    var movieshow: movie?
    
    @IBOutlet weak var moviewebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var moviename = movieshow!.title!.replacingOccurrences(of: " ", with: "-")

            moviename = moviename.lowercased()
        
            moviename = moviename.replacingOccurrences(of: "vol.-", with: "")
        
        let movieid = movieshow!.id!

        if let url = URL(string: "https://www.themoviedb.org/movie/\(movieid)-\(moviename)") {
            
            moviewebview.loadRequest(URLRequest(url: url))
            //他會不確定有沒有url, 所以在let url前面加if, 這樣成功才會跑這句
            
        
               }
        
        self.title = movieshow!.title //這樣可以在navigator那邊的正中間跑出電影名稱
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

