//
//  BooksViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit

class BooksViewController: UIViewController {
    
    let theme: AppTheme = NewsAppTheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements(){
        view.backgroundColor = theme.color.viewsBackgroundColor
    }

}
