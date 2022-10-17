//
//  FavouriteSegments.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/02/1444 AH.
//
import Foundation

import UIKit

enum FavouriteSegments: Int, CaseIterable {
    
    case news
    case movies
    
    var rowHeight: CGFloat {
        switch self {
        case .news:
            return 100 /// check: may be changed
        case .movies:
            return 100
        }
    }
    
    var title: String {
        switch self {
        case .news:
            return "News"
        case .movies:
            return "Movies"
        }
    }
}
