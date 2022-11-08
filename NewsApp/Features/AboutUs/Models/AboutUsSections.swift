//
//  AboutUsSections.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 13/04/1444 AH.
//

import Foundation

enum AboutUsSections: Int, CaseIterable {
    
    case intro
    case overview
    case credits
    
    var sectionAnimation: String {
        switch self {
        case .intro:
            return "lf30_editor_m0hbp4n8"
        case .overview:
            return "lf30_editor_wqnllm6r"
        case .credits:
            return "lf30_editor_yqq48htr"
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .intro:
            return "Thank You For Using\nDaily News"
        case .overview:
            return "Overview"
        case.credits:
            return "Credits"
        }
    }
    
    var sectionContent: NSMutableAttributedString {
        switch self {
        case .intro:
            return NSMutableAttributedString(string:"Daily News is an app that provides the option to browse, and save your favorite news, movie reviews , and books. ")
        case .overview:
            return "\u{2022} Daily News was developed by Madawi with the guidance of a wonderful senior co-workers, with an intention to have the greatest amount of exposure to new skills and techniques in iOS development.\n\n\u{2022} Its important to mention that Daily News may ask you for the permission to access the “Camera” and “Photo album” for you to be able to update the profile picture. ".formatHypelinks(ranges: ["Madawi"])
        case.credits:
            return "\u{2022} Daily News displayed materials are taken from The New York Times Developer Network APIs.\n\n\u{2022} All materials are protected by the copyright law, and they cannot be altered without a prior written permission from the New York Times company.\n\n\u{2022} Daily News animations are taken from LottieFiles.com".formatHypelinks(ranges: ["The New York Times Developer Network APIs","LottieFiles.com"])
        }
    }
}
