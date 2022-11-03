//
//  NewsAppTheme.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/01/1444 AH.
//

import UIKit
import SVProgressHUD

struct NewsAppTheme: AppTheme {
    
    var color: ColorTheme = NewsAppColorTheme()
    
    var font: FontTheme = NewsAppFontTheme()
    
    // MARK: Button
    
    func stylePrimaryButton (_ button: UIButton){
        button.titleLabel?.font = font.primaryButtonFont
        button.titleLabel?.textColor = .black
        button.tintColor = .clear
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
    }
    
    func styleTitleFourButton (_ button: UIButton){
        button.titleLabel?.font = font.titleFourButtonFont
        button.titleLabel?.textColor = color.orangeLightColorEC8B3F
    }
    
    func styleSecondaryButton (_ button: UIButton){
        button.titleLabel?.font = font.primaryButtonFont
        button.titleLabel?.textColor = color.grayDarkColor343B3C
        button.tintColor = color.grayDarkColor343B3C
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    // MARK: Lable
    
    func styleTitleOneLable(_ lable: UILabel) {
        lable.font = font.titleOneFont
        lable.textColor = color.grayDarkColor343B3C
    }
    
    func styleTitleFourLable (_ lable: UILabel) {
        lable.font = font.titleSixFont
        lable.textColor = color.grayLightColor9fa1a1
    }
    
    func styleSloganLable (_ lable: UILabel){
        lable.font = font.sloganFont
        lable.textColor = .white.withAlphaComponent(0.7)
    }
    
    func styleErrorLable (_ lable: UILabel) {
        lable.font = font.errorFont
        lable.textColor = .red
    }
    
    // MARK: TextField
    
    func styleTextField (_ textField: UITextField){
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.clipsToBounds = true
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    // MARK: View
    
    func styleViewCard (_ viewCard: UIView){
        viewCard.layer.cornerRadius = 30
        viewCard.clipsToBounds = true
    }
    
    func styleSVProgressHUD() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setMaximumDismissTimeInterval(2.5)
        SVProgressHUD.setForegroundColor(UIColor.black.withAlphaComponent(0.8))
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.13))
        SVProgressHUD.setBackgroundColor(UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0))
    }  
}
