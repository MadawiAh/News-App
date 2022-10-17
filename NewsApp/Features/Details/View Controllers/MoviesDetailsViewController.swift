//
//  MoviesDetailsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 19/02/1444 AH.
//

import UIKit

class MoviesDetailsViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isCriticsPickLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mpaaRatingView: UIView!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var copyrightsLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    var movie: MoviesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setUpElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements() {
        
        dateLabel.font = theme.font.titleFifeFont
        dateLabel.textColor = theme.color.grayLightColor9fa1a1
        
        isCriticsPickLabel.font = theme.font.titleSixFont
        isCriticsPickLabel.textColor = theme.color.orangeDarkColorEB652B.withAlphaComponent(0.8)
        
        headlineLabel.font = theme.font.titleTwoFont
        headlineLabel.textColor = theme.color.grayDarkColor343B3C
        
        bylineLabel.font = theme.font.titleFifeFont
        bylineLabel.textColor = theme.color.grayLightColor9fa1a1
        
        summaryLabel.font = theme.font.titleFourFont
        summaryLabel.textColor = theme.color.grayMediumColor546062
        
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
        
        mpaaRatingView.layer.cornerRadius = 10
        mpaaRatingView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        mpaaRatingLabel.font = theme.font.titleFifeFont
        mpaaRatingLabel.textColor = UIColor.black
    }
    
    private func setUpElements() {
        guard let movie = movie else {return}
        
        dateLabel.text = movie.publicationDate.getFormattedDate(currentFormat: "yyyy-MM-dd")
        headlineLabel.text = movie.headline
        bylineLabel.text = "By " + movie.byline
        summaryLabel.text = movie.summaryShort
        copyrightsLabel.text = Secrets.copyrights
        mpaaRatingView.isHidden = true
        isCriticsPickLabel.isHidden = true
        
        if movie.hasMpaaRating {
            mpaaRatingLabel.text = movie.mpaaRating
            mpaaRatingView.isHidden = false
        }
        if movie.criticsPick == 1 {
            setUpIsCriticPrickLabel()
        }
        
        guard let completeURL = URL(string: "\(movie.multimedia.src)")
        else {return}
        
        imageView.kf.setImage(with: completeURL, placeholder: UIImage(named: "poster-placeholder.png"))
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
    
    private func setUpIsCriticPrickLabel() {
        
        let isCriticsPickString = NSMutableAttributedString(string:"")
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "star.fill")!.withTintColor(theme.color.orangeDarkColorEB652B.withAlphaComponent(0.8))
        imageAttachment.bounds = CGRect(x: 0, y: -1, width: 12, height: 12)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        isCriticsPickString.append(imageString)
        isCriticsPickString.append(NSAttributedString(string:" Critics's Pick"))
        
        isCriticsPickLabel.attributedText = isCriticsPickString
        isCriticsPickLabel.isHidden = false
    }
    
    private func toggleFavourite() {
        
        var img = UIImage(systemName: "suit.heart.fill")
        var color: UIColor = theme.color.orangeDarkColorEB652B
        
        if favouriteBtn.imageView?.image == UIImage(systemName: "suit.heart.fill") {
            img = UIImage(systemName: "suit.heart")
            color = theme.color.grayLightColor9fa1a1
        }
        favouriteBtn.setImage(img, for: .normal)
        favouriteBtn.tintColor = color
    }
    
    // MARK: User Actions

    @objc func readMoreTapped(withSender sender: UITapGestureRecognizer) {
        openLink(forURL: movie!.link.url)
    }
    
    @objc func favouriteTapped(withSender sender: UIButton) {
        Animator.animateButton(buttonToAnimate: sender)
        toggleFavourite()
    }
    
    @objc func shareTapped(withSender sender: UIButton) {
        shareActivity(forURL: movie!.link.url)
    }
}
