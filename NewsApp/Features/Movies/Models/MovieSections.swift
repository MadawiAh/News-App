//
//  MovieSections.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 16/02/1444 AH.
//

import UIKit

enum MovieSections: Int, CaseIterable {
    
    case criticPicks
    case recentReviews
    
    var numberOfRows: Int {
        switch self {
        case .criticPicks:
            return 1
        case .recentReviews:
            return 5
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .criticPicks:
            return 210
        case .recentReviews:
            return 100
        }
    }
    
    var title: String {
        switch self {
        case .criticPicks:
            return "Critics' Picks"
        case .recentReviews:
            return "Recent Reviews"
        }
    }
    
    var numberOfColumns: Int {
        switch self {
        case .criticPicks:
            return 5
        default:
            return 1
        }
    }
}


