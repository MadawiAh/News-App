//
//  TabBarController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit

class TabBarController: UITabBarController {
    
    let theme: AppTheme = NewsAppTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setupTabBarPages()
    }
    
    private func styleElements(){
        tabBar.unselectedItemTintColor = theme.color.grayLightColor9fa1a1
        tabBar.tintColor = theme.color.orangeDarkColorEB652B
        tabBar.backgroundColor = theme.color.viewsBackgroundColor
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = theme.color.grayLightColor9fa1a1.cgColor
        
    }
    
    private func setupTabBarPages(){
        
        let newsVC = UINavigationController(rootViewController:
                                                UIStoryboard.news.instantiateViewController(withIdentifier: "NewsViewController"))
        let moviesVC = UINavigationController(rootViewController:
                                                UIStoryboard.movies.instantiateViewController(withIdentifier: "MoviesViewController"))
        let booksVC = UINavigationController(rootViewController:
                                                UIStoryboard.books.instantiateViewController(withIdentifier: "BooksViewController"))
        let moreVC = UINavigationController(rootViewController:
                                                UIStoryboard.more.instantiateViewController(withIdentifier: "MoreViewController"))
        
        
        let viewControllers = [newsVC, moviesVC, booksVC, moreVC]
        let titles = ["News","Movies","Books","More"]
        let images = [UIImage(systemName: "newspaper"), UIImage(systemName: "film"), UIImage(systemName: "book"), UIImage(systemName: "ellipsis")]
        
        for x in 0..<viewControllers.count {
            viewControllers[x].tabBarItem = UITabBarItem(
                title: titles[x],
                image: images[x],
                tag: x)
        }
        
        setViewControllers(viewControllers, animated: false)
    }
    
}
