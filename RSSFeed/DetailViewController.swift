//
//  DetailViewController.swift
//  RSSFeed
//
//  Created by Varad on 04/01/17.
//  Copyright © 2017 MobileFirst. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var article2Display:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let article = article2Display {
            
            if let url = URL(string: article.articleLink) {
                
                let request = URLRequest(url: url)
                
                webView.loadRequest(request)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
