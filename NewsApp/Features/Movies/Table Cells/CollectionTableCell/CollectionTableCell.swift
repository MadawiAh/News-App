//
//  CollectionTableViewCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

import UIKit

class CollectionTableCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let theme: AppTheme = NewsAppTheme()
    var collectionDidScroll = false {
        didSet{
            pageControl.currentPage = Int(
                (collectionView.contentOffset.x / (collectionView.frame.width / 2))
                    .rounded(.toNearestOrAwayFromZero)
            )
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleElements()
        registerCollectionViewCells()
    }
    
    private func styleElements() {
        
        selectionStyle = .none
        
        pageControl.pageIndicatorTintColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = theme.color.orangeLightColorEC8B3F
        pageControl.numberOfPages = MovieSections.criticPicks.numberOfColumns
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UINib(nibName: "InnerCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "InnerCollectionViewCell")
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}
