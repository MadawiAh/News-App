//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 16/02/1444 AH.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leadParagraphLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var copyrightsLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    var news: NewsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setUpNews()
    }
    
    func styleElements() {
        
        dateLabel.font = theme.font.titleFifeFont
        dateLabel.textColor = theme.color.grayLightColor9fa1a1
        
        headlineLabel.font = theme.font.titleTwoFont
        headlineLabel.textColor = theme.color.grayDarkColor343B3C
        
        abstractLabel.font = theme.font.titleFourFont
        abstractLabel.textColor = theme.color.grayMediumColor546062
        
        bylineLabel.font = theme.font.titleFifeFont
        bylineLabel.textColor = theme.color.grayLightColor9fa1a1
        
        leadParagraphLabel.font = theme.font.titleFourFont
        leadParagraphLabel.textColor = theme.color.grayMediumColor546062
        
        copyrightsLabel.font = theme.font.titleSevenFont
        copyrightsLabel.textColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.7)
        
        readMoreLabel.textColor = theme.color.orangeLightColorEC8B3F
        readMoreLabel.font = theme.font.titleFifeFont
        setUpReadMoreButton()
        
        favouriteBtn.tintColor = theme.color.grayLightColor9fa1a1
        favouriteBtn.addTarget(self, action: #selector(favouriteTapped(withSender:)), for: .touchUpInside)
        
        shareBtn.tintColor = theme.color.grayLightColor9fa1a1
        shareBtn.addTarget(self, action: #selector(shareTapped(withSender:)), for: .touchUpInside)
        
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "poster-placeholder.png")
    }
    
    func setUpNews() {
        guard let news = news else {return}
        
        dateLabel.text = news.pubDate.getFormattedDate(currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ" )
        headlineLabel.text = news.headline.main
        let byline = news.byline.original ?? ""
        bylineLabel.text = news.timeToRead + (!byline.isEmpty ? " | \(byline)" : "")
        abstractLabel.text = news.abstract
        leadParagraphLabel.text = news.leadParagraph
        copyrightsLabel.text = Secrets.copyrights
        
        imageView.isHidden = false
        if news.multimedia.isEmpty {
            imageView.isHidden = true
            return
        }
        guard let completeURL = URL(string: "https://www.nytimes.com/\(news.multimedia[0].url)")
        else {return}
        
        imageView.kf.setImage(with: completeURL, placeholder: UIImage(named: "news-placeholder.png"))
    }
    
    private func setUpReadMoreButton() {
        
        let content = "Read more at NYTimes site "
        let readMoreString = NSMutableAttributedString(string: content)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.up.right")!.withTintColor(theme.color.orangeLightColorEC8B3F)
        imageAttachment.bounds = CGRect(x: 0, y: -1, width: 11, height: 11)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        readMoreString.append(imageString)
        readMoreString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: content.count))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewsDetailsViewController.readMoreTapped))
        
        readMoreLabel.attributedText = readMoreString
        readMoreLabel.isUserInteractionEnabled = true
        readMoreLabel.addGestureRecognizer(tap)
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
    }
    
    private func openLink(forURL url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: User Actions
    
    @objc func readMoreTapped(withSender sender: UITapGestureRecognizer) {
        openLink(forURL: news!.webURL)
    }
    
    @objc func favouriteTapped(withSender sender: UIButton) {
        Animator.animateButton(buttonToAnimate: sender)
        toggleFavourite()
    }
    
    @objc func shareTapped(withSender sender: UIButton) {
        shareActivity(forURL: news!.webURL)
    }
}
