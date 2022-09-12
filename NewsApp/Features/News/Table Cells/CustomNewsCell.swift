//
//  CustomNewsCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 26/01/1444 AH.
//

import UIKit
import Kingfisher

protocol NewsCellUpdater: AnyObject {
    func refreshTableView()
}

class CustomNewsCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsPublishTime: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    let theme: AppTheme = NewsAppTheme()
    var shareTappedClosure: ((CustomNewsCell)->())?
    weak var delegate: NewsCellUpdater?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
        
    }
    
    func styleElements(){
        
        selectionStyle = .none
        
        contentStack.layer.cornerRadius = 10
        contentStack.backgroundColor = .white
        
        styleShadowView()
        styleNewsImage()
        
        newsTitle.textColor = theme.color.grayDarkColor343B3C
        newsTitle.font = theme.font.titleThreeFont
        
        newsPublishTime.textColor = theme.color.grayLightColor9fa1a1
        newsPublishTime.font = theme.font.titleSixFont
        
        favouriteBtn.tintColor = theme.color.grayLightColor9fa1a1
        shareBtn.tintColor = theme.color.grayLightColor9fa1a1
    }
    
    
    private func styleShadowView() {
        shadowView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                y: 0,
                                                                width: shadowView.layer.frame.width - shadowView.layer.frame.width/12, height: shadowView.layer.frame.height + shadowView.layer.frame.height/35
                                                               )).cgPath
        shadowView.layer.shadowColor = theme.color.grayLightColor9fa1a1.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: -2)
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 5
    }
    
    private func styleNewsImage() {
        newsImage.image = UIImage(named: "news-placeholder.png")
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.heightAnchor.constraint(equalToConstant: 190).isActive = true
        newsImage.layer.cornerRadius = 10
        newsImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setNews(news: NewsData){
        
        newsTitle.text = news.headline.main
        newsPublishTime.text = "\(news.formatedDate) • \(news.timeToRead == 0 ? "less than" : (String(describing: news.timeToRead))) min read"
        
        newsImage.isHidden = false
        if news.multimedia.isEmpty {
            newsImage.isHidden = true
            return
        }
        
        guard let completeURL = URL(string: "https://www.nytimes.com/\(news.multimedia[0].url)")
        else {return}
        
        newsImage.kf.setImage(with: completeURL, placeholder: UIImage(named: "news-placeholder.png")){ result, error in
            self.delegate?.refreshTableView()
        }
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
