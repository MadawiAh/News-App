//
//  BooksDetailsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 27/03/1444 AH.
//

import UIKit

class BooksDetailsViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var weeksOnListLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var AdditionalInfoTitleLabel: UILabel!
    @IBOutlet weak var publisherTitleLabel: UILabel!
    @IBOutlet weak var publisherValueLabel: UILabel!
    @IBOutlet weak var isbn10TitleLabel: UILabel!
    @IBOutlet weak var isbn10ValueLabel: UILabel!
    @IBOutlet weak var isbn13TitleLabel: UILabel!
    @IBOutlet weak var isbn13ValueLabel: UILabel!
    @IBOutlet weak var buyLinksLabel: UILabel!
    @IBOutlet weak var sellerOneBtn: UIButton!
    @IBOutlet weak var sellerTwoBtn: UIButton!
    @IBOutlet weak var sellerThreeBtn: UIButton!
    @IBOutlet weak var sellerFourBtn: UIButton!
    @IBOutlet weak var copyrightsLabel: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    var book: BookData?
    var section: String?
    var colorIndex: Int?
    var addtionalInfoIsCollapsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setUpBook()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements() {
        
        coverImageView.image = UIImage(named: "book-placeholder.png")
        coverImageView.layer.cornerRadius = 3
        coverImageView.layer.borderWidth = 0.1
        coverImageView.layer.borderColor = theme.color.grayLightColor9fa1a1.cgColor
        coverImageView.dropShadow()
        
        titleLabel.font = theme.font.titleThreeFont
        titleLabel.textColor = theme.color.grayDarkColor343B3C
        
        autherLabel.font = theme.font.titleSixFont
        autherLabel.textColor = theme.color.grayBluishColor80A2A9
        
        sectionLabel.backgroundColor = SectionColors.allCases[colorIndex ?? 0].colorFromHex
        sectionLabel.layer.cornerRadius = 4
        sectionLabel.clipsToBounds = true
        sectionLabel.font = theme.font.titleSevenFont
        sectionLabel.textColor = UIColor.white
        
        rankLabel.font = theme.font.titleSixFont
        rankLabel.textColor = theme.color.orangeDarkColorEB652B.withAlphaComponent(0.7)
        
        weeksOnListLabel.font = theme.font.titleSevenFont
        weeksOnListLabel.textColor = theme.color.grayLightColor9fa1a1
        
        descriptionLabel.font = theme.font.titleFifeFont
        descriptionLabel.textColor = theme.color.grayMediumColor546062
        
        AdditionalInfoTitleLabel.font = theme.font.titleFourFont
        AdditionalInfoTitleLabel.textColor = theme.color .grayDarkColor343B3C
        AdditionalInfoTitleLabel.text = "Additional Info"
        
        publisherTitleLabel.font = theme.font.titleSixFont
        publisherTitleLabel.textColor = theme.color.grayMediumColor546062
        publisherTitleLabel.text = "Publisher"
        
        publisherValueLabel.font = theme.font.titleSixFont
        publisherValueLabel.textColor = theme.color.grayLightColor9fa1a1
        
        isbn10TitleLabel.font = theme.font.titleSixFont
        isbn10TitleLabel.textColor = theme.color.grayMediumColor546062
        isbn10TitleLabel.text = "ISBN-10"
        
        isbn10ValueLabel.font = theme.font.titleSixFont
        isbn10ValueLabel.textColor = theme.color.grayLightColor9fa1a1
        
        isbn13TitleLabel.font = theme.font.titleSixFont
        isbn13TitleLabel.textColor = theme.color.grayMediumColor546062
        isbn13TitleLabel.text = "ISBN-13"
        
        isbn13ValueLabel.font = theme.font.titleSixFont
        isbn13ValueLabel.textColor = theme.color.grayLightColor9fa1a1
        
        buyLinksLabel.font = theme.font.titleFourFont
        buyLinksLabel.textColor = theme.color .grayDarkColor343B3C
        buyLinksLabel.text = "Seller's Links"
        
        setUpSellers()
        
        copyrightsLabel.font = theme.font.titleEightFont
        copyrightsLabel.textColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.7)
    }
    
    private func setUpSellers() {
        
        sellerOneBtn.setImage(UIImage(named: "amazon-logo.png"), for: .normal)
        sellerOneBtn.layer.cornerRadius = 10
        sellerOneBtn.clipsToBounds = true
        sellerOneBtn.tag = 0
        
        sellerTwoBtn.setImage(UIImage(named: "apple-books-logo.jpg"), for: .normal)
        sellerTwoBtn.layer.cornerRadius = 10
        sellerTwoBtn.clipsToBounds = true
        sellerTwoBtn.tag = 1
        
        sellerThreeBtn.setImage(UIImage(named: "barnes-and-noble-logo.png"), for: .normal)
        sellerThreeBtn.layer.cornerRadius = 10
        sellerThreeBtn.clipsToBounds = true
        sellerThreeBtn.tag = 2
        
        sellerFourBtn.setImage(UIImage(named: "books-a-million-logo.png"), for: .normal)
        sellerFourBtn.layer.cornerRadius = 10
        sellerFourBtn.clipsToBounds = true
        sellerFourBtn.tag = 3
    }
    
    private func setUpBook() {
        guard let book = book else {return}
        
        titleLabel.text = book.title
        autherLabel.text = "By " + book.author
        sectionLabel.text = " \(section ?? "") "
        rankLabel.text = "#\(book.rank) this week"
        weeksOnListLabel.text = book.weeksOnList == 0 ? "Newly added this week" : "\(book.weeksOnList) weeks on the list"
        descriptionLabel.text = book.bookDescription
        publisherValueLabel.text = book.publisher
        isbn10ValueLabel.text = book.primaryIsbn10
        isbn13ValueLabel.text = book.primaryIsbn13
        copyrightsLabel.text = Secrets.copyrights
        
        guard let completeURL = URL(string: "\(book.bookImage)")
        else {return}
        
        coverImageView.kf.setImage(with: completeURL, placeholder: UIImage(named: "book-placeholder.png"))
    }
    
    //MARK: - User Actions
    
    @IBAction func openSellerLink(_ sender: UIButton) {
        Animator.animateButton(buttonToAnimate: sender)
        if let url = book?.buyLinks[sender.tag].url {
            openLink(forURL: url)
        }
    }
}
