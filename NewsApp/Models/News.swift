//
//  News.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/01/1444 AH.
//

import Foundation
import UIKit

struct News {
    let image: UIImage?
    let title: String
    let createdAt: String
    let numberOfWords: Int
    var timeToRead: Int {
        get {
            return Int(round(Double(numberOfWords)/200.0))
        }
    }
}
