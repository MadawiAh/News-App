//
//  AppTheme.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/01/1444 AH.
//

import UIKit
import SVProgressHUD

protocol AppTheme {
    
    var color: ColorTheme { get }
    
    var font: FontTheme { get }
    
    // MARK: Button
    
    func stylePrimaryButton (_ button: UIButton)
    
    func styleTitleFourButton (_ button: UIButton)
    
    func styleSecondaryButton (_ button: UIButton)
    
    // MARK: Lable
    
    func styleTitleOneLable (_ lable: UILabel)
    
    func styleTitleFourLable (_ lable: UILabel)
    
    func styleSloganLable (_ lable: UILabel)
    
    func styleErrorLable (_ lable: UILabel)
    
    // MARK: TextField
    
    func styleTextField (_ textField: UITextField)
    
    // MARK: View
    
    func styleViewCard (_ viewCard: UIView)
    
    func styleSVProgressHUD ()
   
}