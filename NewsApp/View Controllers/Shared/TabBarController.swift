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
                                                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController"))
        let moviesVC = UINavigationController(rootViewController:
                                                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController"))
        let tvVC = UINavigationController(rootViewController:
                                                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TVViewController"))
        let moreVC = UINavigationController(rootViewController:
                                                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController"))
      

        let viewControllers = [newsVC, moviesVC, tvVC, moreVC]
        let titles = ["News","Movies","TV","More"]
        let images = [UIImage(systemName: "newspaper"), UIImage(systemName: "film"), UIImage(systemName: "tv"), UIImage(systemName: "ellipsis")]
        
        for x in 0..<viewControllers.count {
            viewControllers[x].isNavigationBarHidden = true
            viewControllers[x].tabBarItem = UITabBarItem(
                title: titles[x],
                image: images[x],
                tag: x)
        }
        
        setViewControllers(viewControllers, animated: false)
    }

}
