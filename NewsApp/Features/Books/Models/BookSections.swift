//
//  BookSections.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 24/03/1444 AH.
//

import UIKit

enum BookSections: Int, CaseIterable {
    
    case hotList
    case bestSellersLists
    
    
    var rowHeight: CGFloat {
        switch self {
        case .hotList:
            return 180
        case .bestSellersLists:
            return 230
        }
    }
    
    var title: String {
        switch self {
        case .hotList:
            return "Hot List"
        case .bestSellersLists:
            return "Best Sellers"
        }
    }
    
    var numberOfColumns: Int {
        switch self {
        case .hotList:
            return 18
        case .bestSellersLists:
            return 5
        }
    }
}

