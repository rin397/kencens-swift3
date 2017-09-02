//
//  TableViewController.swift
//  線上電影
//
//  Created by EricaSung on 2017/8/28.
//  Copyright © 2017年 Erica. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&page=1&api_key=846dcd9bb4f09f2705d110fb8ea03212"
    var movies = [movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        downloadpage(url: url){ (count) in //count因為是int, 也是這個func最後跑出來的page

            let page = count - 16120
            
            for i in 1...page { //page太多頁惹, 改成2就好惹

                self.url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&page=\(i)&api_key=846dcd9bb4f09f2705d110fb8ea03212"
                //把外面的url調用進來, 要加self
            
                self.downloadmovie(url: self.url){(array) in //把downloadmovie功能調用到這個新功能下, 功能跟url都要加self
                    self.movies += array as! [movie]
                    //把func讀到的array轉成[movie]的格式, 調用到movies, 就可以使用movies惹
                    //改成+=才能夠把新的頁數的movie append到之前的裡面, 不然會一直被洗掉
                    //但改成+=後, 之前download movie為了加速有把一個插隊下載的code放在for loop中, 要把他移出來
                    //不然就會一直下載一直append
                    self.tableView.reloadData() //把tableview調用進來, 另外就是因為每次都要加載, 所以要用reloaddata
                    
                }

            }
        
        }
        
        //不用加！ 外？
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1 //1欄
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movies.count //10列
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let moviecell = movies[indexPath.row] //因為movies是array

        cell.textLabel?.text = moviecell.title
//        cell.detailTextLabel?.text = moviecell.date
        
        var votestr = "\(String(describing: moviecell.vote_average))"
        votestr = (votestr as NSString).substring(with: NSMakeRange(9, 3))
        cell.detailTextLabel?.text = "🌟" + votestr

        downloadposter(url: moviecell.poster!) { (data) in
            cell.imageView?.image = UIImage(data: data)
            
            self.resizecellimage(cell) //建立完resize後就調用進來tableview函數, 才能夠在讀圖片的時候就帶入
        }
        
        // 定義資料內容

        return cell
    }
    
    
    func resizecellimage(_ cell: UITableViewCell) {
        let imagesize = CGSize(width: 110.0, height: 150.0)
        UIGraphicsBeginImageContextWithOptions(imagesize, false, 0.0) //開始調整圖片, false: 保留圖片透明度, 0.0: 沒有位移
        let imagerect = CGRect(x: 0, y: 0, width: imagesize.width, height: imagesize.height) //建框
        cell.imageView?.image?.draw(in: imagerect) //把image畫到框框裡面
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext() //剛剛設定的這些去跟cell.imageview連結
        
        //也可以把它改成圓形
        //cell.imageView!.layer.cornerRadius = imagesize.width/2 //把角落改成圓弧狀
        //cell.imageView!.layer.masksToBounds = true //在圓形外的部分就把他切掉
        
        UIGraphicsEndImageContext()
        
    }
    
    //建立function抓電影
    func downloadmovie(url:String, completionHandler: @escaping (NSArray) -> ()){
        //completionHandler = 想要讓這個功能送回一個 Array, 送Array是因為要把他塞到tableview中
        //加了以後會返回值, 所以要加 -> (), 上面在用這個func的時候也要記得加{(array) in }
    
        var movieitems = [movie]()
        //有很多部movie(剛剛建好的movie object格式), 所以他是個array, 被[]包起來
        //建一個空array 塞等等for loop放的每部movie
        
        if let url = URL(string:url) { //把string轉成URL //如果URL存在再往下設定request跟task
        
          //1.  let request = NSMutableURLRequest(url: url) //request = 去url抓資料
          //2.  let task = URLSession.shared.dataTask(with: request) //抓資料

          //這兩個可以變成下面這個
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (
                data, response, error) in
                if error != nil {
                
                    print(error) //是error就print
                    
                } else {
                
                    if let urlcontent = data{ //抓url的內容
                    
                        do {
                            
                            let jsonresult = try JSONSerialization.jsonObject(
                                with: urlcontent,
                                options: JSONSerialization.ReadingOptions.mutableContainers
                                ) as! NSDictionary
                            //NS = Jobs之前的公司 所以有功能的東西都會用NS開頭 
                            //因為json是字典格式(中括號夾冒號), 所以要轉dictionary才行

                            
                            //抓json的內容
                            
                            let items = jsonresult["results"] as! NSArray
                            //因為他是[,,,]的格式, 所以是數組不是字典, 也要定義
                            //print((item[0] as! NSDictionary)["title"])
                            
                            for item in items {
                            
                                let dictionary = item as! NSDictionary //建一個dictionary, 把items的每個item做成dictionary的格式放進來, 再送進新的變項中
                                
                                let title = dictionary["title"] as! String
                                //這裡的dictionary["title"]就是剛剛抓到的json的title
                                //as String是配合剛剛做好的movie object (那裡都是設String)
                                let date = dictionary["release_date"] as! String
                                let id = dictionary["id"] as! Int
                                let vote_count = dictionary["vote_count"] as! Int
                                let vote_average = dictionary["vote_average"] as! Float
                                let poster1 = dictionary["poster_path"] as! String
                                let poster = "https://image.tmdb.org/t/p/w500/\(poster1)"
                            
                                let moviefin = movie(title: title, date: date, id: id, vote_count: vote_count, vote_average: vote_average, poster: poster)
                                //這就是剛設的initial值
                                //把從json讀到的東西送到各個常量後再送進這個movie object中(透過initial)
                            
                                movieitems.append(moviefin) //一部一部電影跑進movieitems, 變成裡面的string
                                

                                
                                
                            }
                            
                        } catch {
                        
                            print("json catch failure")
                        
                        }
                    DispatchQueue.main.async(execute: {
                        completionHandler(movieitems as NSArray)
                        }) //所有程式都是要排隊執行的, 加上dispatchquene.main他就可以排第一順位,資料會跑很快
                    }
                    
                }
            })
        
            task.resume()
        
        }
    
    }

    //建立function抓海報
    func downloadposter(url:String, completionHandler: @escaping (Data) -> ()){
        
        if let url = URL(string:url) {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if error != nil { print(error) } else {
                    
                    if let posterdata = data{ //抓url的內容
                        
                        DispatchQueue.main.async(execute: {

                            self.tableView.reloadData() //自動刷新資料(在開啟APP時已經顯示所有圖片)
                            self.refreshControl?.endRefreshing() //停止自動刷新
                            
                            completionHandler(posterdata)
                        })
                        
                        
                    }
                    
                }
            })
            
            task.resume()
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailinfo" {
        
            let viewcontroller = segue.destination as! ViewController //把viewcontroller變成常量
            let index = tableView.indexPathForSelectedRow //選擇的是第幾個
            let movieselect = movies[index!.row] //把選擇的資料帶進來 //先去tableview建一個movie
        
            viewcontroller.movieshow = movieselect
        }
    }

    func downloadpage(url:String, completionHandler: @escaping (Int) -> ()){
        //completionHandler = 想要讓這個功能送回一個Int, 加了以後會返回值, 所以要加 -> ()
        
        var page = 0
        //先給page一個初始值, 因為會是int, 所以給0
        
        if let url = URL(string:url) {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (
                data, response, error) in
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let urlcontent = data{
                        
                        do {
                            
                            let jsonresult = try JSONSerialization.jsonObject(
                                with: urlcontent,
                                options: JSONSerialization.ReadingOptions.mutableContainers
                                ) as! NSDictionary
                            //因為json是字典格式(中括號夾冒號), 所以要轉dictionary才行
                            
                            //抓json的內容
                            
                            page = jsonresult["total_pages"] as! Int
                            
                            DispatchQueue.main.async(execute: {
                            completionHandler(page)
                            })
                                
                        } catch {
                            
                            print("json catch failure")
                            
                        }
                        
                    }
                    
                }
            })
            
            task.resume()
            
        }
        
    }

    
}
