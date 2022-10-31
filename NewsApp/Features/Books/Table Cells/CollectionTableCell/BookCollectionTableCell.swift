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
    @IBOutlet weak var pageControl: UIPageControl!
    
    let theme: AppTheme = NewsAppTheme()
    var collectionDidScroll = false {
        didSet{
            updatePageControl()
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
        
        pageControl.pageIndicatorTintColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = theme.color.orangeLightColorEC8B3F
        pageControl.numberOfPages = 5
        
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
        collectionView.contentOffset.x = 0
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
    
    private func configureBestSellerSections() {
        sectionView.backgroundColor = SectionColors.allCases[(collectionView.tag-1) % 13].colorFromHex
        sectionView.isHidden = false
        pageControl.isHidden = true
    }
    
    private func configureHotListSection() {
        sectionView.isHidden = true
        pageControl.isHidden = false
    }
    
    private func updatePageControl() {
        pageControl.currentPage = Int(
            (collectionView.contentOffset.x / (collectionView.frame.width))
                .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    // MARK: - Public Helpers
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        row == 0 ? configureHotListSection() : configureBestSellerSections()
        resetOffset()
        collectionView.reloadData()
    }
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}
