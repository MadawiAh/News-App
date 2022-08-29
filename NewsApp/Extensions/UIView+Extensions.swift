//
//  UIView+Extensions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 27/01/1444 AH.
//

import UIKit

extension UIView {
    
    func makeRounded() {
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
//        clipsToBounds = true
    }
}
