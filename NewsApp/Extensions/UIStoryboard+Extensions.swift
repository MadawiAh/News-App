//
//  UIStoryboard+Extensions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 27/01/1444 AH.
//

import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
    
    static var news: UIStoryboard {
        return UIStoryboard(name: "News", bundle: nil)
    }
    
    static var movies: UIStoryboard {
        return UIStoryboard(name: "Movies", bundle: nil)
    }
    
    static var details: UIStoryboard {
        return UIStoryboard(name: "Details", bundle: nil)
    }
    
    static var tv: UIStoryboard {
        return UIStoryboard(name: "TV", bundle: nil)
    }
    
    static var more: UIStoryboard {
        return UIStoryboard(name: "More", bundle: nil)
    }
    
    static var favourites: UIStoryboard {
        return UIStoryboard(name: "Favourites", bundle: nil)
    }
}
