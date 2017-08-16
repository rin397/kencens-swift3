//
//  TableViewController.swift
//  movieApp
//
//  Created by Wilson Hsieh on 2017/8/15.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var url:String?
    var movies = [Movie]()
    var imgUrl = "http://image.tmdb.org/t/p/w185/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=fd8f2abd9ae2bdfea4f1d917ad82ce4e"
        
        downloadMovice(url:url!){
            (arrary) in
            self.movies = arrary as! [Movie]
        }
    }
    
    func downloadMovice( url:String , completionHandler: @escaping (NSArray) ->() )  {
        
        var movies = [Movie]()
        if let url = URL(string:url){
            print(url)
            //            let request = NSMutableURLRequest(url:url)
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response,
                error) in
               
                if error != nil{
                    
                    print(error)
                    
                }else{
                    if let urlContent = data {
                        
                        do {
                            
                            let jsonObj =
                                try JSONSerialization.jsonObject(
                                    with: urlContent,
                                    options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            
                            let results = jsonObj["results"] as! NSArray
                            
                            for obj in results{
                                let item = obj as! NSDictionary
                                
                                let title = item["title"] as! String
                                
                                let releaseDate = item["release_date"]as! String
                                
                                let id = item["id"]as! Int
                                
                                let postPath = item["poster_path"]as! String
                                
                                let overview = item["overview"]as! String
                                
                                let voteCount = item["vote_count"] as! Int
                                
                                let voteAverage = item["vote_average"] as! Float
                                
                                let movie = Movie(title:title , releaseDate:releaseDate, id:id ,postPath:postPath , overview:overview , voteCount:voteCount, voteAverage:voteAverage )
                                
                                movies.append( movie)
                                
                                DispatchQueue.main.async {
                                    completionHandler(movies as NSArray)
                                }
                            }
                        }catch{
                            
                            print("json error")
                            
                        }
                        completionHandler(movies as NSArray)
                    }
                    
                }
                
            }).resume()
            
        }
    }
    
    func downloadImg( url:String , completionHandler: @escaping (Data) ->() )  {
        
        if let url = URL(string:url){
            //            let request = NSMutableURLRequest(url:url)
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response,
                error) in
                
                if error != nil{
                    
                    print(error)
                    
                }else{
                    if let postData = data {
                        
                        DispatchQueue.main.async {
                            //                            self.tableView.reloadData()
                            //                            self.refreshControl?.endRefreshing()
                            completionHandler(postData)
                        }
                        
                        
                        
                    }
                    
                }
                
            })
            
            task.resume()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCellTableViewCell
        
        if self.movies.count > indexPath.row {
            
            
            cell.movieTitle.text = self.movies[indexPath.row].title
            
            
            
            downloadImg(url: imgUrl+self.movies[indexPath.row].postPath!){
                (data) in
                //let iv = UIImageView(image: UIImage(data:data))
                self.movies[indexPath.row].dataImg = UIImage(data:data)
                cell.imgData.image = self.movies[indexPath.row].dataImg
                var frame = cell.imageView?.frame
                cell.imageView?.frame = frame!
                //cell.addSubview(iv)
            }

        }
       
        cell.setStarValue(starValue: (self.movies[indexPath.row].voteAverage! - 5))

        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowDetail" {
            var showDetailController = segue.destination as! ViewController
            var index = self.tableView.indexPathForSelectedRow?.row
            var selecteMovie = movies[ index! ]
            
            showDetailController.movie = selecteMovie
            
        }
    }
    
}
