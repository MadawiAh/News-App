//
//  MoreTableViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 01/02/1444 AH.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var titleTwo: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        styleElements()
        setUpElements()
        
    }
    func styleElements (){
        
        imageOne.tintColor = theme.color.grayLightColor9fa1a1
        imageTwo.tintColor = theme.color.grayLightColor9fa1a1
        
        titleOne.textColor = theme.color.grayMediumColor546062
        titleTwo.textColor = theme.color.grayMediumColor546062
        
        titleOne.font = theme.font.titleFourFont
        titleTwo.font = theme.font.titleFourFont
    }
    
    func setUpElements(){
        imageOne.image = MoreActions.favourites.image
        imageTwo.image = MoreActions.shareApp.image
        
        titleOne.text = MoreActions.favourites.label
        titleTwo.text = MoreActions.shareApp.label
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
            // navigation
        }
        if MoreActions.allCases[indexPath.row] == .shareApp {
            self.shareActivity(forURL: "https://google.com//")
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
