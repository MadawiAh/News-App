//
//  NewsController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 26/01/1444 AH.
//
import Alamofire
import UIKit

class NewsController {
    
    func fetchNewsData(year: String, month:String, success: (([NewsData])->Void)?, failure: ((Error) -> Void)? = nil){
        
        APIService(url: nil, service: .getNews(year: year, month: month), method: .get).executeCall{ (result: Result<NewsNetworkCall,Error>) in
            switch result{
            case .success(let news):
                var newsArray = news.response.docs
                newsArray = newsArray.filter{$0.documentType == "article"}
                success?(newsArray)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}
