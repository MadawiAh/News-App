//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/01/1444 AH.
//

import UIKit

class NewsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let theme: AppTheme = NewsAppTheme()
    private let newsController = NewsController()
    let refreshControl = UIRefreshControl()
    var news: [News] = []
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        registerTableViewCells()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "News"
        
        fetchNewsData()
    }
    
    private func setUpTableView() {
        tableView.estimatedRowHeight = 115.0;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshTable()
    }
    
    private func registerTableViewCells() {
        let newsCell = UINib(nibName: "CustomNewsCell",
                                  bundle: nil)
        tableView.register(newsCell,
                                forCellReuseIdentifier: "CustomNewsCell")
    }
    
    private func fetchNewsData() {
        newsController.fetchNewsData() { result in
            self.news = result
        }
    }
    
    private func refreshTable(){
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        /// temp until API calls are implemented
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Refreshed!")
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: Table View Datasource and Delegate

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigation
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNews = news[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNewsCell") as! CustomNewsCell
        cell.setNews(news: currentNews)
        
        cell.shareTappedClosure = { [weak self] cell in
            
            guard let self = self,
                  let indexPath = tableView.indexPath(for: cell)
                        else { return }
            
            self.shareActivity(forURL: self.news[indexPath.row].url)
        }
        
        return cell
    }
    
}
