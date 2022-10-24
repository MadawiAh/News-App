//
//  BookUpperCollectionCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 24/03/1444 AH.
//

import UIKit

class BookUpperCollectionCell: UICollectionViewCell {
    
    static let nibName = "BookUpperCollectionCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements(){
        
        containerView.layer.cornerRadius = 15
        containerView.dropShadow()
        
        cover.image = UIImage(named: "book-placeholder.png")
        cover.layer.cornerRadius = 3
        cover.layer.borderWidth = 0.1
        cover.layer.borderColor = theme.color.grayLightColor9fa1a1.cgColor
        cover.dropShadow()
        
        title.font = theme.font.titleSixFont
        title.textColor = theme.color.grayDarkColor343B3C
        
        auther.font = theme.font.titleSevenFont
        auther.textColor = theme.color.grayBluishColor80A2A9
        
        section.backgroundColor = theme.color.orangeLightColorEC8B3F
        section.layer.cornerRadius = 4
        section.clipsToBounds = true
        section.font = theme.font.titleEightFont
        section.textColor = UIColor.white
        
        bookDescription.font = theme.font.titleSevenFont
        bookDescription.textColor = theme.color.grayLightColor9fa1a1
    }
    
    // MARK: - Public Helpers
    
    func setBook(book: BookData, fromSection sec:String, at row:Int, refreshTable: (()->())?){
        title.text = book.title
        auther.text = "By " + book.author
        section.text = " " + sec + " "
        section.backgroundColor = SectionColors.allCases[row % 13].colorFromHex
        bookDescription.text = book.bookDescription
        
        guard let completeURL = URL(string: "\(book.bookImage)")
        else {return}
        
        cover.kf.setImage(with: completeURL, placeholder: UIImage(named: "book-placeholder.png")){ result, error in
            refreshTable?()
        }
    }
}
