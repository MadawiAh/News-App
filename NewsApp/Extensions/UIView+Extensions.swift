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
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .init(width: 0, height: 0)
        layer.shadowRadius = 7
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
