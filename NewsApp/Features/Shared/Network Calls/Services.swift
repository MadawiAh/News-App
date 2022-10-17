//
//  Services.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

enum Services{
    
    case getNews(year: String, month:String)
    
    var endPoint: String {
        switch self {
        case .getNews(let year, let month):
            return "archive/v1/\(year)/\(month).json?api-key=\(Secrets.apiKey)"
        
        /// other screens API calls endpoints will be added later
        
        }
    }
}
