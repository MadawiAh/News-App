//
//  ViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/01/1444 AH.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var sloganPart1: UILabel!
    @IBOutlet weak var sloganPart2: UILabel!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let theme: AppTheme = NewsAppTheme()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
    }
    
    private func styleElements(){
      
        theme.stylePrimaryButton(logInBtn)
        theme.stylePrimaryButton(signUpBtn)
        
        theme.styleSloganLable(sloganPart1)
        theme.styleSloganLable(sloganPart2)

    }
}

