//
//  MoviesViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit
import SVProgressHUD

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let theme: AppTheme = NewsAppTheme()
    private let moviesController = MoviesController()
    private let refreshControl = UIRefreshControl()
    private var criticPicksMovies = [MoviesData]()
    private var recentlyReviewedMovies = [MoviesData]()
    private var lastContentOffset: CGFloat = 0
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpProgressHUD()
        setUpRefreshControl()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Movies"
        fetchCriticPicks()
        fetchRecentMovieReviews()
    }
    
    // MARK: - Private Helpers
    
    private func setUpTableView() {
        tableView.backgroundColor = theme.color.grayBrightColorf9f9f9
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpProgressHUD(){
        theme.styleSVProgressHUD()
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show(withStatus: "Loading latest reviews ...")
    }
    
    private func setUpRefreshControl(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        self.fetchCriticPicks()
        self.fetchRecentMovieReviews()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: MovieCollectionTableCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: MovieCollectionTableCell.cellIdentifier)
        tableView.register(UINib(nibName: CustomMoviesTableCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: CustomMoviesTableCell.cellIdentifier)
    }
    
    private func setUpEmptyListLable() {
        
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.numberOfLines = 2
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.font = theme.font.titleSixFont
        emptyLabel.textColor = theme.color.grayLightColor9fa1a1
        emptyLabel.text = "Oops there are no reviews! \n Swipe down to refresh"
        
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func setUpSectionHeaderView(for sectionType: MovieSections) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        /// Header title
        let titleLabel = UILabel(frame: CGRect(x: 7, y: 0, width: 180, height: 30))
        titleLabel.textColor = theme.color.grayDarkColor343B3C
        titleLabel.font = theme.font.titleFourFont
        
        /// Header button
        let seeAllBtn: UIButton = UIButton(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 30))
        seeAllBtn.setTitle("See All", for: .normal)
        seeAllBtn.setTitleColor(theme.color.orangeLightColorEC8B3F, for: .normal)
        seeAllBtn.titleLabel?.font = theme.font.titleSixFont
        seeAllBtn.addTarget(self, action: #selector(seeAllTapped(withSender:)), for: .touchUpInside)
        
        switch sectionType {
        case .criticPicks:
            titleLabel.text = MovieSections.criticPicks.title
            seeAllBtn.tag = MovieSections.criticPicks.rawValue
        case .recentReviews:
            titleLabel.text = MovieSections.recentReviews.title
            seeAllBtn.tag = MovieSections.recentReviews.rawValue
        }
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(seeAllBtn)
        
        return headerView
    }
    
    @objc private func seeAllTapped(withSender sender: UIButton) {
        
        let vc = UIStoryboard.movies.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        
        switch sender.tag {
        case MovieSections.criticPicks.rawValue:
            vc.moviesList = criticPicksMovies
            vc.barTitle = MovieSections.criticPicks.title
            
        default:
            vc.moviesList = recentlyReviewedMovies
            vc.barTitle = MovieSections.recentReviews.title
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updateViews() {
        if isFitchedSuccessfully() {
            self.tableView.backgroundView = nil
        }
        refreshTableView()
        SVProgressHUD.dismiss()
        refreshControl.endRefreshing()
    }
    
    private func refreshTableView() {
        tableView.reloadData()
    }
    
    private func isFitchedSuccessfully() -> Bool {
        return !criticPicksMovies.isEmpty && !recentlyReviewedMovies.isEmpty
    }
    
    // MARK: - Fetching Moives
    
    private func fetchCriticPicks() {
        moviesController.fetchCriticPicks { [weak self] fetchedMovies in
            
            guard let self = self else {return}
            self.criticPicksMovies = fetchedMovies
            DispatchQueue.main.async {
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
    
    private func fetchRecentMovieReviews(){
        
        moviesController.fetchRecentMovieReviews { [weak self] fetchedMovies in
            guard let self = self else {return}
            self.recentlyReviewedMovies = fetchedMovies
            DispatchQueue.main.async {
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

// MARK: - UITableView DataSource and Delegate

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MovieSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isFitchedSuccessfully() {
            setUpEmptyListLable()
            return 0
        }
        let sectionType = MovieSections.allCases[section]
        switch sectionType {
        case .criticPicks:
            return MovieSections.criticPicks.numberOfRows
        case .recentReviews:
            return MovieSections.recentReviews.numberOfRows
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = MovieSections.allCases[indexPath.section]
        switch sectionType {
        case .criticPicks:
            return MovieSections.criticPicks.rowHeight
        case .recentReviews:
            return MovieSections.recentReviews.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isFitchedSuccessfully() {return nil}
        let sectionType = MovieSections.allCases[section]
        return setUpSectionHeaderView(for: sectionType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = MovieSections.allCases[indexPath.section]
        
        switch sectionType {
        case .criticPicks:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionTableCell.cellIdentifier, for: indexPath) as! MovieCollectionTableCell
            return cell
        case .recentReviews:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomMoviesTableCell.cellIdentifier, for: indexPath) as! CustomMoviesTableCell
            guard !recentlyReviewedMovies.isEmpty else {return cell}
            
            let currentMovie = recentlyReviewedMovies[indexPath.row]
            cell.setMovie(movie: currentMovie){
                self.refreshTableView()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MovieCollectionTableCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == MovieSections.criticPicks.rawValue {return}
       
        let vc = UIStoryboard.details.instantiateViewController(withIdentifier: "MoviesDetailsViewController") as! MoviesDetailsViewController
        vc.movie = recentlyReviewedMovies[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /// check if horizontal scrolling
        if (self.lastContentOffset > scrollView.contentOffset.x) || (self.lastContentOffset < scrollView.contentOffset.x) {
            
            if let collectionCell = tableView.cellForRow( at: IndexPath( row: 0,
                                                                         section: MovieSections.criticPicks.rawValue)) as? MovieCollectionTableCell{
                collectionCell.collectionDidScroll = true
            }
        }
    }
}

// MARK: - UICollectionView DataSource and Delegate

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieSections.criticPicks.numberOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieInnerCollectionCell.cellIdentifier, for: indexPath)  as! MovieInnerCollectionCell
        
        guard !criticPicksMovies.isEmpty else {return cell}
        
        let currentMovie = criticPicksMovies[indexPath.row]
        
        cell.setMovie(movie: currentMovie){
            self.refreshTableView()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.details.instantiateViewController(withIdentifier: "MoviesDetailsViewController") as! MoviesDetailsViewController
        vc.movie = criticPicksMovies[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 180)
    }
}
