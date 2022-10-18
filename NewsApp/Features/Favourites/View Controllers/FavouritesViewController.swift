//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 02/02/1444 AH.
//
import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var segmentsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let theme: AppTheme = NewsAppTheme()
    private var newsFavourites = [NewsData]()
    private var movieFavourites = [MoviesData]()
    private var currentSegment = 0 {
        didSet {
            refreshTableView()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSegmentedControl()
        setUpTableView()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Favourites"
        /// getting data
    }
    
    // MARK: - Private Helpers
    
    private func setUpSegmentedControl() {
        
        var titles = [String]()
        FavouriteSegments.allCases.forEach { titles.append($0.title) }
        
        let segmenetedControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: segmentsView.frame.height), buttonTitles: titles)
        
        segmenetedControl.indexChangedClosure = { [weak self] indx in
            guard let self = self else {return}
            self.currentSegment = indx
        }
        segmentsView.addSubview(segmenetedControl)
    }
    
    private func setUpTableView() {
        tableView.backgroundColor = theme.color.grayBrightColorf9f9f9
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 115.0;
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: CustomNewsCell.nibName,
                                 bundle: nil),
                           forCellReuseIdentifier: CustomNewsCell.nibName)
        tableView.register(UINib(nibName: "CustomMoviesTableCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CustomMoviesTableCell")
    }
    
    private func setUpEmptyListLable() {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.numberOfLines = 2
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.font = theme.font.titleFifeFont
        emptyLabel.textColor = theme.color.grayLightColor9fa1a1
        emptyLabel.text = "There are no favourites"
        
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func refreshTableView(){
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    private func doHaveFavourites() -> Bool {
        return !newsFavourites.isEmpty && !movieFavourites.isEmpty
    }
}

// MARK: - Table View Datasource and Delegate

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !doHaveFavourites() {
            setUpEmptyListLable()
            return 0
        }
        switch currentSegment {
        case FavouriteSegments.news.rawValue:
            return newsFavourites.count
            
        default:
            return movieFavourites.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentSegment {
        case FavouriteSegments.news.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomNewsCell.nibName) as! CustomNewsCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMoviesTableCell", for: indexPath) as! CustomMoviesTableCell
            return cell
        }
    }
}
