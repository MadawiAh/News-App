//
//  BookInnerCollectionCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/03/1444 AH.
//

import UIKit

class BookInnerCollectionCell: UICollectionViewCell {
    
    static let nibName = "BookInnerCollectionCell"
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var auther: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleElements()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements(){
        
        cover.image = UIImage(named: "book-placeholder.png")
        cover.layer.cornerRadius = 3
        cover.layer.borderWidth = 0.1
        cover.layer.borderColor = theme.color.grayLightColor9fa1a1.cgColor
        cover.dropShadow()
        
        title.font = theme.font.titleSevenFont
        title.textColor = theme.color.grayDarkColor343B3C
        
        auther.font = theme.font.titleEightFont
        auther.textColor = theme.color.grayBluishColor80A2A9
    }
    
    // MARK: - Public Helpers
    
    func setBook(book: BookData, refreshTable: (()->())?){
        title.text = book.title
        auther.text = "By " + book.author
        
        guard let completeURL = URL(string: "\(book.bookImage)")
        else {return}
        
        cover.kf.setImage(with: completeURL, placeholder: UIImage(named: "book-placeholder.png")){ result, error in
            refreshTable?()
        }
    }
}
