//
//  Animator.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 25/01/1444 AH.
//

import Foundation
import UIKit

class Animator {
    
    static func animateButton(buttonToAnimate button: UIButton){
        
        UIView.animate(withDuration: 0.05,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: .curveEaseIn,
                       animations: {
            
            button.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            
            UIView.animate(withDuration: 0.05,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 2,
                           options: .curveEaseIn,
                           animations: {
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}
