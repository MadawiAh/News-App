//
//  CustomMoviesTableCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 15/02/1444 AH.
//

import UIKit

class CustomMoviesTableCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var isCriticsPickLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    weak var delegate: MovieCellsUpdater?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
    }
    func styleElements(){
        
        selectionStyle = .none
        
        poster.layer.cornerRadius = 5
        poster.image = UIImage(named: "poster-placeholder.png")
        
        titleLabel.font = theme.font.titleFourFont
        titleLabel.textColor = theme.color.grayMediumColor546062
        
        summaryLabel.font = theme.font.bodyFifeFont
        summaryLabel.textColor = theme.color.grayLightColor9fa1a1
        
        bylineLabel.font = theme.font.titleSevenFont
        bylineLabel.textColor = theme.color.grayLightColor9fa1a1
        
        isCriticsPickLabel.font = theme.font.titleSevenFont
        isCriticsPickLabel.textColor = theme.color.orangeDarkColorEB652B.withAlphaComponent(0.8)
    }
    
    func setMovie(movie: MoviesData){
        titleLabel.text = movie.displayTitle
        summaryLabel.text = movie.summaryShort
        bylineLabel.text = "By " + movie.byline
        isCriticsPickLabel.isHidden = true
        
        if movie.isCriticsPick {
            setUpIsCriticPrickLabel()
            isCriticsPickLabel.isHidden = false
        }
        
        guard let completeURL = URL(string: "\(movie.multimedia.src)")
        else {return}
        
        poster.kf.setImage(with: completeURL, placeholder: UIImage(named: "poster-placeholder.png")){ result, error in
            self.delegate?.refreshTableView()
        }
    }
    
    func setUpIsCriticPrickLabel() {
        
        let templateString = NSMutableAttributedString(string:"")
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "star.fill")!.withTintColor(theme.color.orangeLightColorEC8B3F.withAlphaComponent(0.8))
        imageAttachment.bounds = CGRect(x: 0, y: -1, width: 10, height: 10)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        templateString.append(imageString)
        templateString.append(NSAttributedString(string:" Critics's Pick"))
        
        isCriticsPickLabel.attributedText = templateString
    }
    
}
