//
//  MoreViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit

class MoreViewController: UIViewController {
    
    let theme: AppTheme = NewsAppTheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()

    }
    
    private func styleElements(){
        view.backgroundColor = theme.color.viewsBackgroundColor
    }

    @IBAction func logOutTapped(_ sender: Any) {
        
        /// 1. update defaults
        UserDefaults.standard.set(false, forKey: "isLogged")
        
        /// 2. navigation
        let landingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingViewController")
        
        landingVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(landingVC, animated: true)
    }
}
