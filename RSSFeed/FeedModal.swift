//
//  FeedModal.swift
//  RSSFeed
//
//  Created by Varad on 04/01/17.
//  Copyright © 2017 MobileFirst. All rights reserved.
//

import UIKit

protocol FeedModelDelegate {
    func articlesReady()
}

class FeedModal: NSObject, XMLParserDelegate {

    let url = "https://www.theverge.com/rss/frontpage"
    var articles = [Article]()
    
    var delegate: FeedModelDelegate?
    
    var constructingArticle:Article?
    var constructingString = ""
    var linkAttributes = [String:String]()
    
    func getArticles() {
        
        // Download the RSS Feed data
        let feedURL = URL(string: url)
        
        if let actualFeedUrl = feedURL {
            let parser = XMLParser(contentsOf: actualFeedUrl)
            
            if let actualParser = parser {
                // We have an actual parser object
                actualParser.delegate = self
                actualParser.parse()
            }
        }
    }
    
    // When the parser finds a new starting tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // We onl care about the <entry>, <title>, <content> and <link> tags
        
        if elementName == "entry" {
            constructingArticle = Article()
        }
        else if elementName == "link" {
            linkAttributes = attributeDict
        }
    }
    
    // when the parser finds the character between the tags
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // Save the data from the tags <title> and <content>
        
        if constructingArticle != nil {
            constructingString += string
        }
    }
    
    // When the parser finds an ending tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // When the ending tag is </entry>, </title>, </content>, </link>
        
        if elementName == "title" {
            // Save the constructing string as the title for our article.
            let title = constructingString.trimmingCharacters(in: .whitespacesAndNewlines)
            constructingArticle?.articleTitle = title
        }
        else if elementName == "content" {
         
            // Save the constructing string as content for our constructing article
            constructingArticle?.articleBody = constructingString
            
            if let startRange = constructingString.range(of: "http") {
                
                if let endRange = constructingString.range(of: ".jpeg") {
                    
                    let substring = constructingString.substring(with: startRange.lowerBound ..< endRange.upperBound)
                    
                    constructingArticle?.articleImageUrl = substring
                
                }
                else if let endRange = constructingString.range(of: ".png") {
                    
                    let substring = constructingString.substring(with: startRange.lowerBound ..< endRange.upperBound)
                    
                    constructingArticle?.articleImageUrl = substring
                }
            }
        }
        else if elementName == "link" {
            // save the href attribute as the article url for our constructing article
            
            if let href = linkAttributes["href"] {
                constructingArticle?.articleLink = href
            }
        }
        else if elementName == "entry" {
            // Save the constructing article into the array
            
            if let a = constructingArticle {
                articles.append(a)
            }
            
            // Reset the constructing article
            constructingArticle = nil
        }
        
        // Reset the constructing String
        constructingString = ""
    }
    
    // When the parser finishes the parsing the feed.
    func parserDidEndDocument(_ parser: XMLParser) {
        
        // When the feed is parsed, we want to notify the delegate.
        
        // check if the delegate is not nil
        if let actualdelegate = delegate {
            actualdelegate.articlesReady()
        }
    }
    
}
