//
//  BookCollectionTableCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/03/1444 AH.
//

import UIKit

class BookCollectionTableCell: UITableViewCell {
    
    static let nibName = "BookCollectionTableCell"
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var sectionName: UILabel!
    
    let theme: AppTheme = NewsAppTheme()
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleElements()
        registerCollectionViewCells()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements() {
        selectionStyle = .none
        
        styleSectionView()
        styleSectionNameLabel()
    }
    
    private func styleSectionView() {
        sectionView.layer.cornerRadius = 8
        sectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        let tap = UITapGestureRecognizer(target: self, action: #selector(BookCollectionTableCell.resetOffset))
        sectionView.addGestureRecognizer(tap)
    }
    
    @objc private func resetOffset(){
        collectionViewOffset = 0
    }
    
    private func styleSectionNameLabel() {
        sectionName.font = theme.font.titleSevenFont
        sectionName.textColor = UIColor.white
        let degrees : Double = -90
        sectionName.transform = CGAffineTransform(rotationAngle: CGFloat(degrees * .pi/180))
        sectionName.frame = sectionView.frame
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UINib(nibName: BookInnerCollectionCell.nibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: BookInnerCollectionCell.cellIdentifier)
        collectionView.register(UINib(nibName: BookUpperCollectionCell.nibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: BookUpperCollectionCell.cellIdentifier)
    }
    
    private func configureSectionView() {
        sectionView.backgroundColor = SectionColors.allCases[(collectionView.tag-1) % 13].colorFromHex
        sectionView.isHidden = false
    }
    
    // MARK: - Public Helpers
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        row == 0 ? sectionView.isHidden = true : configureSectionView()
        resetOffset()
        collectionView.reloadData()
    }
}
