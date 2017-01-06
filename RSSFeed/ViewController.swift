//
//  ViewController.swift
//  RSSFeed
//
//  Created by Varad on 04/01/17.
//  Copyright © 2017 MobileFirst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FeedModelDelegate, UITableViewDelegate, UITableViewDataSource {

    var model = FeedModal()
    var articles = [Article]()
    
    var selectedArticle: Article?
    
    @IBOutlet weak var tblRSSFeeds: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Kick off te Article download in the background.
        model.delegate = self
        model.getArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Implement FeedModelDelegate methods
    
    func articlesReady() {
        // Get the articles from the model
        articles = model.articles
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FeedCell
        
        // Get the article at that particular row
        let article = articles[indexPath.row]
        
        cell.lblFeedTitle.text = article.articleTitle
        
        if article.articleImageUrl != "" {
            
            // create url object
            let url = URL(string: article.articleImageUrl)
            
            // create url request object
            if let actualURL = url {
                
                let request = URLRequest(url: actualURL)
             
                // Grab the current UrlSession
                let session = URLSession.shared
                
                //Create a URLSession Data Task
                let datatask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    
                    // data has been downloaded and create the uiimage object
                    if data != nil {
                        cell.imgFeedBG.image = UIImage(data: data!)
                    }
                })
             
                // Fire off data task
                datatask.resume()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedArticle = articles[indexPath.row]
        
        performSegue(withIdentifier: "toDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailView" {
            
            let destVC = segue.destination as! DetailViewController
            
            destVC.article2Display = selectedArticle!
        }
    }


}

