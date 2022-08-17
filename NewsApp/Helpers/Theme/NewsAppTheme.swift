//
//  NewsAppTheme.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/01/1444 AH.
//

import UIKit

struct NewsAppTheme: AppTheme {
    
    var color: ColorTheme = NewsAppColorTheme()
    
    var font: FontTheme = NewsAppFontTheme()
    
    // MARK: Button
    
    func stylePrimaryButton (_ button: UIButton){
        button.titleLabel?.font = font.primaryButtonFont
        button.titleLabel?.textColor = .red
//        button.tintColor = .clear
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
    }
    
    func styleTitleFourButton (_ button: UIButton){
        button.titleLabel?.font = font.titleFourButtonFont
        button.titleLabel?.textColor = color.orangeLightColorEC8B3F
    }
    
    // MARK: Lable
    
    func styleTitleOneLable(_ lable: UILabel) {
        lable.font = font.titleOneFont
        lable.textColor = color.grayDarkColor343B3C
    }
    
    func styleTitleFourLable (_ lable: UILabel) {
        lable.font = font.titleFourFont
        lable.textColor = color.grayLightColor9fa1a1
    }
    
    func styleSloganLable (_ lable: UILabel){
        lable.font = font.sloganFont
        lable.textColor = .white
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
    
    
    
}
