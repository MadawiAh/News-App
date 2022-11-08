//
//  MoreActions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 02/02/1444 AH.
//
import UIKit

enum MoreActions: CaseIterable {
    
    case favourites
    case clearCache
    case aboutUs
    case shareApp
    
    var image: UIImage? {
        switch self {
        case .favourites:
            return UIImage(systemName: "heart.fill")
        case .clearCache:
            return UIImage(systemName: "trash")
        case .aboutUs:
            return UIImage(systemName: "questionmark.app.dashed")
        case .shareApp:
            return UIImage(systemName: "square.and.arrow.up")
        }
    }
    
    var label: String {
        switch self {
        case .favourites:
            return "Favourites"
        case .clearCache:
            return "Clear Cache"
        case .aboutUs:
            return "About Us"
        case .shareApp:
            return "Share Daily News"
        }
    }
}
