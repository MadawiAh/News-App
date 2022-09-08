//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/01/1444 AH.
//

import UIKit
import SVProgressHUD

class NewsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let theme: AppTheme = NewsAppTheme()
    private let newsController = NewsController()
    private let refreshControl = UIRefreshControl()
    private var news = [NewsData]()
    private var pageSize = 0
    
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpProgressHUD()
        setUpRefreshControl()
        registerTableViewCells()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "News"
        fetchNewsData()
    }
    
    // MARK: Views Set Up methods
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 115.0;
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpProgressHUD(){
        theme.styleSVProgressHUD()
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show(withStatus: "Loading latest news ...")
    }
    
    private func setUpRefreshControl(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.fetchNewsData()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "CustomNewsCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CustomNewsCell")
    }
    
    private func setUpFooterSpinner(_ tableView: UITableView) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        spinner.startAnimating()
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.pageSize += 10
            self.refreshTableView()
            self.tableView.tableFooterView = nil
        }
    }
    
    private func setUpEmptyListLable() {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.numberOfLines = 2
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.font = theme.font.titleFifeFont
        emptyLabel.textColor = theme.color.grayLightColor9fa1a1
        emptyLabel.text = "Oops there are no news! \n Swipe down to refresh"
        
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func updateViews() {
        refreshTableView()
        SVProgressHUD.dismiss()
        refreshControl.endRefreshing()
        view.isUserInteractionEnabled = true
    }
    
    // MARK: Fetching news
    
    private func fetchNewsData() {
        let now = Date() /// temp
        newsController.fetchNewsData( year:"\(now.getComponent(.year))", month:"\(now.getComponent(.month))") { [weak self] fetchedNews in
                
                guard let self = self else {return}
                self.news = fetchedNews
                self.pageSize = 10
                DispatchQueue.main.async {
                    self.updateViews()
                    self.tableView.backgroundView = nil
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

// MARK: Table View Datasource and Delegate

extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            setUpFooterSpinner(tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news.count == 0 { setUpEmptyListLable()}
        else { tableView.backgroundView = nil }
        return pageSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNewsCell") as! CustomNewsCell
        
        cell.delegate = self
        guard !news.isEmpty else {return cell}
        
        let currentNews = news[indexPath.row]
        cell.setNews(news: currentNews)
        cell.shareTappedClosure = { [weak self] cell in
            
            guard let self = self,
                  let indexPath = tableView.indexPath(for: cell) else { return }
            self.shareActivity(forURL: self.news[indexPath.row].webURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// TODO: Navigation to details page
    }
}

// MARK: NewsCellUpdater protocol

extension NewsViewController: NewsCellUpdater{
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
