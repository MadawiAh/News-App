//
//  NewsAppFontTheme.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 19/01/1444 AH.
//

import Foundation
import UIKit

struct NewsAppFontTheme: FontTheme {
    
    // MARK: Button
    
    var primaryButtonFont: UIFont {
        return UIFont.systemFont(ofSize: 23)
    }
    var titleFourButtonFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    // MARK: Lable
    
    var sloganFont: UIFont {
        return UIFont(name: "Sinhala Sangam MN", size: 35)!
    }
    
    var errorFont: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    var titleOneFont: UIFont {
        return UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    var titleFourFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .medium)
    }
}
