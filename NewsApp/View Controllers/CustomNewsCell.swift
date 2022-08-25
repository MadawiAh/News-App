//
//  CustomNewsCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 26/01/1444 AH.
//

import UIKit

class CustomNewsCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsCreationTime: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    let theme: AppTheme = NewsAppTheme()
    var shareTappedClosure: ((CustomNewsCell)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
    }

    func styleElements(){
        
        selectionStyle = .none
        
        contentStack.layer.cornerRadius = 10
        contentStack.backgroundColor = .white
        
        shadowView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                y: 0,
                                                                width: shadowView.layer.frame.width - shadowView.layer.frame.width/11, height: shadowView.layer.frame.height
                                                               )).cgPath
        shadowView.layer.shadowColor = theme.color.grayLightColor9fa1a1.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -2)
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 5
        
        newsTitle.textColor = theme.color.grayDarkColor343B3C
        newsTitle.font = theme.font.titleThreeFont
        
        newsCreationTime.textColor = theme.color.grayLightColor9fa1a1
        newsCreationTime.font = theme.font.titlefiveFont
        
        favouriteBtn.tintColor = theme.color.grayLightColor9fa1a1
        shareBtn.tintColor = theme.color.grayLightColor9fa1a1
    }
    
    func setNews(news: News){
        
        newsImage.image = news.image
        
        if let _ = newsImage.image {
            newsImage.translatesAutoresizingMaskIntoConstraints = false
            newsImage.heightAnchor.constraint(equalToConstant: 190).isActive = true
            newsImage.layer.cornerRadius = 10
            newsImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        newsTitle.text = news.title
        newsCreationTime.text = "\(news.createdAt) • \(String(describing: news.timeToRead)) min read"
    }
    
    private func toggleFavourite(){
        
        var img = UIImage(systemName: "suit.heart.fill")
        var color: UIColor = theme.color.orangeDarkColorEB652B
        
        if favouriteBtn.imageView?.image == UIImage(systemName: "suit.heart.fill") {
            img = UIImage(systemName: "suit.heart")
            color = theme.color.grayLightColor9fa1a1
        }
        
        favouriteBtn.setImage(img, for: .normal)
        favouriteBtn.tintColor = color
        favouriteBtn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        favouriteBtn.imageView?.widthAnchor.constraint(equalToConstant: 26).isActive = true
        favouriteBtn.imageView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    // MARK: User Actions
    
    @IBAction func favouriteTapped(_ sender: UIButton) {
        Animator.animateButton(buttonToAnimate: sender)
        toggleFavourite()
    }
    
    @IBAction func shareTapped(_ sender: UIButton) {
        Animator.animateButton(buttonToAnimate: sender)
        shareTappedClosure?(self)
    }
    
}
