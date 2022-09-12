//
//  CollectionTableViewCell.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

import UIKit

class CollectionTableCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        registerCollectionViewCells()
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
    
}
