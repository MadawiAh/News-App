//
//  CustomShadowView.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 25/01/1444 AH.
//

import Foundation
import UIKit

class CustomShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            print(" GOING TO setupShadow")
            setupShadow()
        }
    }

    private func setupShadow() {
//        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
//        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
