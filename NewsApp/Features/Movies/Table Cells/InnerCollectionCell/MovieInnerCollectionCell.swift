//
//  MovieInnerCollectionCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

import UIKit

class MovieInnerCollectionCell: UICollectionViewCell {
    
    static let nibName = "MovieInnerCollectionCell"
    
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var mpaaRatingView: UIView!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements(){
        
        poster.image = UIImage(named: "poster-placeholder.png")
        
        mpaaRatingView.layer.cornerRadius = 5
        mpaaRatingView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        mpaaRatingLabel.font = theme.font.titleSevenFont
        mpaaRatingLabel.textColor = UIColor.black
        
        cellContainer.layer.cornerRadius = 10
        cellContainer.backgroundColor = theme.color.grayBrightColorf9f9f9
        cellContainer.layer.borderWidth = 1
        cellContainer.layer.borderColor = theme.color.grayBrightColorf9f9f9.cgColor
        cellContainer.layer.masksToBounds = true
        
        titleLabel.font = theme.font.titleSixFont
        titleLabel.textColor = theme.color.grayMediumColor546062
        
        bylineLabel.font = theme.font.titleEightFont
        bylineLabel.textColor = theme.color.grayLightColor9fa1a1
    }
    
    private func getTitleFromHeadline(movie: MoviesData) -> String {
        return movie.headline.getSlice(from: "‘", to: "’ R") ?? ""
    }
    
    // MARK: - Public Helpers
    
    func setMovie(movie: MoviesData, refreshTable: (()->())?){
        titleLabel.text = movie.displayTitle.emptyAsNil() ?? getTitleFromHeadline(movie: movie)
        bylineLabel.text = "By " + movie.byline
        mpaaRatingLabel.text = movie.mpaaRating
        mpaaRatingView.isHidden = true
       
        if movie.hasMpaaRating {
            mpaaRatingLabel.text = movie.mpaaRating
            mpaaRatingView.isHidden = false
        }
       
        guard let completeURL = URL(string: "\(movie.multimedia.src)")
        else {return}
        
        poster.kf.setImage(with: completeURL, placeholder: UIImage(named: "poster-placeholder.png")){ result, error in
            refreshTable?()
        }
    }
}
