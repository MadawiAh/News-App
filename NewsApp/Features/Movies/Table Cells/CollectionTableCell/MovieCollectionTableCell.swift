//
//  MovieCollectionTableCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

import UIKit

class MovieCollectionTableCell: UITableViewCell {
    
    static let nibName = "MovieCollectionTableCell"
    
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
    
    // MARK: - Private Helpers
    
    private func styleElements() {
        
        selectionStyle = .none
        
        pageControl.pageIndicatorTintColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = theme.color.orangeLightColorEC8B3F
        pageControl.numberOfPages = MovieSections.criticPicks.numberOfColumns
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UINib(nibName: MovieInnerCollectionCell.nibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: MovieInnerCollectionCell.cellIdentifier)
    }
    
    // MARK: - Public Helpers
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
    
    // MARK: - User Actions
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {

        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}
