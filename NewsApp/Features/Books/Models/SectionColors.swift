//
//  SectionColors.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 27/03/1444 AH.
//
import UIKit

enum SectionColors: String, CaseIterable {
    
    case darkGreen = "#8CAD88"
    case lightGreen = "#D5D79A"
    case darkBlue = "#434B8F"
    case lightBlue = "#7586BE"
    case darkPurple = "#6C4E8B"
    case lightPurple = "#B0A5C5"
    case darkPink = "#D37F98"
    case lightPink = "#EBADBD"
    case darkRed = "#C76C67"
    case lightRed = "#F0C3B3"
    case darkOrange = "#E48152"
    case lightOrange = "#F1B58A"
    case darkYellow = "#EBC850"
    case lightYellow = "#E6D778"
    
    var colorFromHex: UIColor {
        return UIColor.colorFromHex(self.rawValue)
    }
}
