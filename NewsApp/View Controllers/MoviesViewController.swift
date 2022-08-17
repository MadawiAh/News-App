//
//  MoviesViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let theme: AppTheme = NewsAppTheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
    }
    
    private func styleElements(){
        view.backgroundColor = theme.color.viewsBackgroundColor
    }

}
