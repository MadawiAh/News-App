//
//  Services.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

enum Services{
    
    case getNews(year: String, month:String)
    case getMovieCriticPicks
    case getRecentMovieReviews
    case getBookList
    
    var endPoint: String {
        switch self {
        case .getNews(let year, let month):
            return "archive/v1/\(year)/\(month).json?api-key=\(Secrets.apiKey)"
       
        case .getMovieCriticPicks:
            return "movies/v2/reviews/picks.json?api-key=\(Secrets.apiKey)"
        
        case .getRecentMovieReviews:
            return "movies/v2/reviews/search.json?api-key=\(Secrets.apiKey)"
        
        case .getBookList:
            return "books/v3/lists/overview.json?api-key=\(Secrets.apiKey)"
       
            /// other screens API calls endpoints will be added later
        
        }
    }
}
