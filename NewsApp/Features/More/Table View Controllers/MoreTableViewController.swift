//
//  MoreTableViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 01/02/1444 AH.
//

import UIKit
import Kingfisher

class MoreTableViewController: UITableViewController {
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var titleTwo: UILabel!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var titleThree: UILabel!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var titleFour: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        styleElements()
        setUpElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements (){
        
        imageOne.tintColor = theme.color.grayLightColor9fa1a1
        imageTwo.tintColor = theme.color.grayLightColor9fa1a1
        imageThree.tintColor = theme.color.grayLightColor9fa1a1
        imageFour.tintColor = theme.color.grayLightColor9fa1a1
        
        titleOne.textColor = theme.color.grayMediumColor546062
        titleTwo.textColor = theme.color.grayMediumColor546062
        titleThree.textColor = theme.color.grayMediumColor546062
        titleFour.textColor = theme.color.grayMediumColor546062
        
        titleOne.font = theme.font.titleFifeFont
        titleTwo.font = theme.font.titleFifeFont
        titleThree.font = theme.font.titleFifeFont
        titleFour.font = theme.font.titleFifeFont
    }
    
    private func setUpElements(){
        imageOne.image = MoreActions.favourites.image
        imageTwo.image = MoreActions.clearCache.image
        imageThree.image = MoreActions.aboutUs.image
        imageFour.image = MoreActions.shareApp.image
        
        titleOne.text = MoreActions.favourites.label
        titleTwo.text = MoreActions.clearCache.label
        titleThree.text = MoreActions.aboutUs.label
        titleFour.text = MoreActions.shareApp.label
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreActions.allCases.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MoreActions.allCases[indexPath.row] == .favourites {
            navigationController?.pushVC(storyboard: .favourites, VCIdetifier: "FavouritesViewController", animated: true)
        }
        if MoreActions.allCases[indexPath.row] == .clearCache {
            self.view.window?.rootViewController?.presentAlert(title: "Clear All Cache?", message: "All your caches will be cleared", options: "OK", "Cancel", style: .alert) { option in
                
                if option == 0 {
                    KingfisherManager.shared.cache.clearCache()
                }
            }
        }
        if MoreActions.allCases[indexPath.row] == .aboutUs {
            navigationController?.pushVC(storyboard: .aboutUs, VCIdetifier: "AboutUsViewController", animated: true)
        }
        if MoreActions.allCases[indexPath.row] == .shareApp {
            self.shareActivity(forURL: "https://google.com//")
        }
    }
}
