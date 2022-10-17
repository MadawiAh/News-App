//
//  MoviesController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 16/02/1444 AH.
//

import Foundation

class MoviesController {
    
    func fetchCriticPicks(success: (([MoviesData])->Void)?, failure: ((Error) -> Void)? = nil){
        
        APIService(url: nil, service: .getMovieCriticPicks, method: .get).executeCall{ (result: Result<MoviesNetworkCall,Error>) in
            switch result{
            case .success(let movies):
                success?(movies.response)
            case .failure(let error):
                failure?(error)
            }
        }
    }
    
    func fetchRecentMovieReviews(success: (([MoviesData])->Void)?, failure: ((Error) -> Void)? = nil){
        
        APIService(url: nil, service: .getRecentMovieReviews, method: .get).executeCall{ (result: Result<MoviesNetworkCall,Error>) in
            switch result{
            case .success(let movies):
                success?(movies.response)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}
