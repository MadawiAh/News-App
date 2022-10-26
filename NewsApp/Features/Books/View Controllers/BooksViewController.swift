//
//  BooksViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/03/1444 AH.
//

import UIKit
import SVProgressHUD

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let theme: AppTheme = NewsAppTheme()
    private let booksController = BooksController()
    private let refreshControl = UIRefreshControl()
    private var bookLists = [BookList]()
    private var hotList = [BookData]()
    private var lastContentOffset: CGFloat = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpProgressHUD()
        setUpRefreshControl()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Books"
        fetchBookLists()
    }
    
    // MARK: - Private Helpers
    
    private func setUpTableView() {
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpProgressHUD(){
        theme.styleSVProgressHUD()
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show(withStatus: "Loading latest books ...")
    }
    
    private func setUpRefreshControl(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        self.fetchBookLists()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: BookCollectionTableCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: BookCollectionTableCell.cellIdentifier)
    }
    
    private func updateViews() {
        if !bookLists.isEmpty {
            tableView.backgroundView = nil
        }
        refreshTableView()
        SVProgressHUD.dismiss()
        refreshControl.endRefreshing()
    }
    
    private func refreshTableView() {
        tableView.reloadData()
    }
    
    private func setUpSectionHeaderView(named sectionTitle: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel(frame: CGRect(x: 6, y: -20, width: 280, height: 70))
        titleLabel.textColor = theme.color.grayDarkColor343B3C
        titleLabel.font = theme.font.titleFourFont
        titleLabel.text = sectionTitle
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    private func setUpEmptyListLable() {
        
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.numberOfLines = 2
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.font = theme.font.titleSixFont
        emptyLabel.textColor = theme.color.grayLightColor9fa1a1
        emptyLabel.text = "Oops there are no books! \n Swipe down to refresh"
        
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setUpHotList() {
        for booklist in bookLists{
            hotList.append(booklist.books[0])
        }
    }
    
    // MARK: - Fetching Book Lists
    
    private func fetchBookLists() {
        booksController.fetchBookLists { [weak self] fetchedLists in
            
            guard let self = self else {return}
            self.bookLists = fetchedLists
            self.setUpHotList()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.updateViews()
            }
        } failure: { error in
            self.showError(error: error){
                DispatchQueue.main.asyncAfter(deadline: .now()+2.5) {
                    self.updateViews()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate and DataSource

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookLists.count + 1 /// the 1 is for the upper hotList section.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookLists.isEmpty {
            setUpEmptyListLable()
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case BookSections.hotList.rawValue:
            return BookSections.hotList.rowHeight
        default:
            return BookSections.bestSellersLists.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !bookLists.isEmpty else {return nil}
        switch section {
        case BookSections.hotList.rawValue:
            return setUpSectionHeaderView(named: BookSections.hotList.title)
        case BookSections.bestSellersLists.rawValue:
            return setUpSectionHeaderView(named: BookSections.bestSellersLists.title)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? BookCollectionTableCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCollectionTableCell.cellIdentifier) as! BookCollectionTableCell
        if !bookLists.isEmpty, indexPath.section > BookSections.hotList.rawValue {
            cell.sectionName.text = bookLists[indexPath.section - 1].displayName
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// check if horizontal scrolling
        if (self.lastContentOffset > scrollView.contentOffset.x) || (self.lastContentOffset < scrollView.contentOffset.x) {
            
            if let collectionCell = tableView.cellForRow( at: IndexPath( row: 0,
                                                                         section: 0)) as? BookCollectionTableCell{
                collectionCell.collectionDidScroll = true
            }
        }
    }
}

// MARK: - UICollectionView DataSource and Delegate

extension BooksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = collectionView.tag
        switch section {
        case BookSections.hotList.rawValue:
            return BookSections.hotList.numberOfColumns
        default:
            return BookSections.bestSellersLists.numberOfColumns
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = collectionView.tag
        switch section {
        case BookSections.hotList.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookUpperCollectionCell.cellIdentifier, for: indexPath)  as! BookUpperCollectionCell
            guard !bookLists.isEmpty else {return cell}
            let currentBook = hotList[indexPath.row]
            cell.setBook(book: currentBook,
                         fromSection: bookLists[indexPath.row].displayName,
                         at: indexPath.row){
                self.refreshTableView()
            }
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookInnerCollectionCell.cellIdentifier, for: indexPath)  as! BookInnerCollectionCell
            
            guard !bookLists.isEmpty else {return cell}
            let currentBook = bookLists[section - 1].books[indexPath.row]
            cell.setBook(book: currentBook){
                self.refreshTableView()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = collectionView.tag
        let vc = UIStoryboard.details.instantiateViewController(withIdentifier: "BooksDetailsViewController") as! BooksDetailsViewController
        if section == 0 {
            vc.book = hotList[indexPath.row]
            vc.section = bookLists[indexPath.row].displayName
            vc.colorIndex = indexPath.row % 13
        } else {
            vc.book = bookLists[section-1].books[indexPath.row]
            vc.section = bookLists[section-1].displayName
            vc.colorIndex = (section-1) % 13
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = collectionView.tag
        switch section {
        case BookSections.hotList.rawValue:
            return CGSize(width: 340, height: 175)
        default:
            return CGSize(width: 140, height: 240)
        }
        
    }
}
