//
//  MoviesListViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 17/02/1444 AH.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var barTitle = String()
    var moviesList = [MoviesData]()
    private let moviesController = MoviesController()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpRefreshControl()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = barTitle
    }
    
    // MARK: - Views SetUp methods
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpRefreshControl(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        switch barTitle {
        case MovieSections.criticPicks.title:
            self.fetchCriticPicks()
        case MovieSections.recentReviews.title:
            self.fetchRecentMovieReviews()
        default:
            refreshControl.endRefreshing()
        }
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: CustomMoviesTableCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: CustomMoviesTableCell.cellIdentifier)
    }
    
    private func updateViews() {
        refreshTableView()
        refreshControl.endRefreshing()
    }
    
    private func refreshTableView() {
        self.tableView.reloadData()
    }
    
    // MARK: - Fetching Moives
    
    private func fetchCriticPicks() {
        moviesController.fetchCriticPicks { [weak self] fetchedMovies in
            
            guard let self = self else {return}
            self.moviesList = fetchedMovies
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
            self.moviesList = fetchedMovies
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

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieSections.recentReviews.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomMoviesTableCell.cellIdentifier, for: indexPath) as! CustomMoviesTableCell
        guard !moviesList.isEmpty else {return cell}
        
        let currentMovie = moviesList[indexPath.row]
        cell.setMovie(movie: currentMovie){
            self.refreshTableView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.details.instantiateViewController(withIdentifier: "MoviesDetailsViewController") as! MoviesDetailsViewController
        vc.movie = moviesList[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
