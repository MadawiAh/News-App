//
//  AppErrors.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/02/1444 AH.
//

import Foundation

enum APIErrors: Error {
    
    case unauthorizedUser
    case tooManyRequests
    case pageNotFound
    case forbidden
    case lostConnection
    case error(description:String =  "",
               statusCode: Int? = -1)
    
    var message: String {
        
        switch self {
        case .unauthorizedUser:
            return "Unauthorized request"
            
        case .tooManyRequests:
            return "Too many requests"
            
        case .pageNotFound:
            return "Page not found"
            
        case .forbidden:
            return "Access forbidden"
            
        case .lostConnection:
            return "Internet connection is lost"
            
        case .error(let description , let code):
            print("\nDescription:" + description + "\nCode\(String(describing: code))")
            return  "Oops we ran into an error \n please try again later"
        }
    }
}
