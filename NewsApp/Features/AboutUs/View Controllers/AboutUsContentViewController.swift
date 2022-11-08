//
//  AboutUsContentViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 13/04/1444 AH.
//

import UIKit
import Lottie

class AboutUsContentViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    var section: AboutUsSections?
    var index = 0
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setUpElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationView.play()
    }
    
    //MARK: - Private Helpers
    
    private func styleElements() {
        titleLabel.font = theme.font.titleTwoFont
        contentLabel.font = theme.font.titleFifeFont
        
        titleLabel.textColor = theme.color.grayBluishColor80A2A9
        contentLabel.textColor = theme.color.grayLightColor9fa1a1
    }
    
    private func setUpElements() {
        animationView.animation = LottieAnimation.named(section?.sectionAnimation ?? "")
        animationView.loopMode = .playOnce
        
        titleLabel.text = section?.sectionTitle
        contentLabel.attributedText = section?.sectionContent
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(contentLabelTapped))
        contentLabel.addGestureRecognizer(tap)
        contentLabel.isUserInteractionEnabled = true
    }
    
    @objc func contentLabelTapped(gesture: UITapGestureRecognizer) {
        
        if gesture.didTapAttributedString("Madawi", in: contentLabel) {
            openLink(forURL: Secrets.madawiLinkedInURL)
            
        } else if gesture.didTapAttributedString("The New York Times Developer Network APIs", in: contentLabel) {
            openLink(forURL: Secrets.nytURL)
            
        } else if gesture.didTapAttributedString("LottieFiles.com", in: contentLabel) {
            openLink(forURL: Secrets.lottieURL)
        }
    }
}
