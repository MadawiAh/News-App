//
//  MoreActions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 02/02/1444 AH.
//
import UIKit

enum MoreActions: CaseIterable {
    
    case favourites
    case shareApp
    
    var image: UIImage {
        switch self {
        case .favourites:
            return UIImage(systemName: "heart.fill")!
        case .shareApp:
            return UIImage(systemName: "square.and.arrow.up")!
        }
    }
    
    var label: String {
        switch self {
        case .favourites:
            return "Favourites"
        case .shareApp:
            return "Share NewsApp"
        }
        
    }
}
