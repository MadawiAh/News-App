//
//  BooksController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 22/03/1444 AH.
//

import Foundation

class BooksController {
    
    func fetchBookLists(success: (([BookList])->Void)?, failure: ((Error) -> Void)? = nil){
        
        APIService(url: nil, service: .getBookList, method: .get).executeCall{ (result: Result<BooksNetworkCall,Error>) in
            switch result{
            case .success(let response):
                success?(response.results.lists)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}
