//
//  MoreTableViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 01/02/1444 AH.
//

import UIKit
import Kingfisher

class MoreTableViewController: UITableViewController {
    
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var titleTwo: UILabel!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var titleThree: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        styleElements()
        setUpElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements (){
       
        imageTwo.tintColor = theme.color.grayLightColor9fa1a1
        imageThree.tintColor = theme.color.grayLightColor9fa1a1
        
        titleTwo.textColor = theme.color.grayMediumColor546062
        titleThree.textColor = theme.color.grayMediumColor546062
        
        titleTwo.font = theme.font.titleFifeFont
        titleThree.font = theme.font.titleFifeFont
    }
    
    private func setUpElements(){
        imageTwo.image = MoreActions.shareApp.image
        imageThree.image = MoreActions.clearCache.image
        
        titleTwo.text = MoreActions.shareApp.label
        titleThree.text = MoreActions.clearCache.label
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreActions.allCases.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MoreActions.allCases[indexPath.row] == .shareApp {
            self.shareActivity(forURL: "https://google.com//")
        }
        if MoreActions.allCases[indexPath.row] == .clearCache {
            self.view.window?.rootViewController?.presentAlert(title: "Clear All Cache?", message: "All your caches will be cleared", options: "OK", "Cancel", style: .alert) { option in
                
                if option == 0 {
                    KingfisherManager.shared.cache.clearCache()
                }
            }
        }
    }
}
