//
//  NewsController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 26/01/1444 AH.
//

import Foundation
import UIKit

class NewsController {
    
    /// temp until API calls are implemented
    func fetchNewsData(success: (([News])->Void)?, failure: ((Error) -> Void)? = nil){
        
        success?([
            News(image: UIImage(named:"news-1")!,
                 title: "Trump Kept More Than 700 Pages of Classified Documents, Letter Says National Archives says",
                 url: "https://www.google.com/",
                 createdAt: "2 min ago",
                 numberOfWords: 560),
            News(image: UIImage(named:"news-2")!,
                 title: "Ex-Detective Admits Misleading Judge Who Approved Breonna Taylor Raid",
                 url: "https://www.google.com/",
                 createdAt: "2 hour ago",
                 numberOfWords: 730),
            News(image: UIImage(named:"news-3")!,
                 title: "Voters in Florida and New York to Decide High-Profile Races",
                 url: "https://www.google.com/",
                 createdAt: "2 hours ago",
                 numberOfWords: 2050),
            News(image: nil,
                 title: "Two Men Convicted in Plot to Kidnap Michigan’s Governor",
                 url: "https://www.google.com/",
                 createdAt: "20 August",
                 numberOfWords: 1600),
            News(image: UIImage(named: "news-4")!,
                 title: "Europe’s Rivers, Starved by Drought, Reveal Shipwrecks and Bombs",
                 url: "https://www.google.com/",
                 createdAt: "18 June",
                 numberOfWords: 2300)
        ])
        /// failure is yet to be implemented
    }
}

