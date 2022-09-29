//
//  ColorTheme.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/01/1444 AH.
//

import UIKit


protocol ColorTheme {
    
    // MARK: Elements colors
    
    var viewsBackgroundColor: UIColor { get }
    
    // MARK: Color plallet
    
    var orangeLightColorEC8B3F: UIColor { get } 
    
    var orangeDarkColorEB652B: UIColor { get }
    
    var grayBrightColorf9f9f9: UIColor { get }
    
    var grayLightColor9fa1a1: UIColor { get }
    
    var grayMediumColor546062: UIColor { get }
    
    var grayDarkColor343B3C: UIColor { get }

}
