//
//  EmptyListView.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 08/04/1444 AH.
//

import UIKit
import Lottie

class EmptyListView: UIView {
    
    static let nibName = "EmptyListView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        Bundle.main.loadNibNamed(EmptyListView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(message: String) {
        messageLabel.font = theme.font.titleSixFont
        messageLabel.textColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.6)
        messageLabel.text = message
        
        animationView.loopMode = .repeat(2)
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.animationView.play()
        }
    }
}
