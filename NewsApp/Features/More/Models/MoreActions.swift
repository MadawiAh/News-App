//
//  MoreActions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 02/02/1444 AH.
//
import UIKit

enum MoreActions: CaseIterable {

    case shareApp
    case clearCache
    
    var image: UIImage {
        switch self {
        case .shareApp:
            return UIImage(systemName: "square.and.arrow.up")!
        case .clearCache:
            return UIImage(systemName: "trash")!
        }
    }
    
    var label: String {
        switch self {
        case .shareApp:
            return "Share Daily News App"
        case .clearCache:
            return "Clear Cache"
        }
    }
}
