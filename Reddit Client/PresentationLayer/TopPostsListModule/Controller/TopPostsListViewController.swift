//
//  TopPostsListViewController.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

class TopPostsListViewController: UIViewController {
    
    // MARK: - Constants
    enum C {
        static let title = "Top Posts"
        static let cellReuseIdentifier = "TopCell"
        static let pullToRefreshTitle = "Pull to refresh"
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var isLoadingNextPosts = false
    
    // MARK: - Properties
    var model: TopPostsListModelInput?
    var router: TopPostsListRouterInput?
    private var posts: [Post] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = C.title
        
        configureIndicatorView()
        configureTableView()
        configurePullToRefresh()
        initialObtainingPosts()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceOrientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func deviceOrientationDidChange() {
        activityIndicatorView.center = view.center
    }

    private func configureIndicatorView() {
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "TopPostTableViewCell", bundle: nil),
                           forCellReuseIdentifier: C.cellReuseIdentifier)
    }
    
    private func initialObtainingPosts() {
        model?.loadArchivedPosts { [weak self] loadedPosts in
            self?.posts = loadedPosts
            self?.tableView.reloadData()
            self?.obtainFreshPosts()
        }
    }
    
    private func obtainFreshPosts() {
        model?.obtainTopPosts(isInitial: true) { [weak self] posts, isSuccess in
            guard let self = self else {
                return
            }
            
            self.activityIndicatorView.stopAnimating()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            if isSuccess {
                self.posts = posts
                self.tableView.reloadData()
                self.model?.savePosts(posts)
            }
        }
    }
    
    private func configurePullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: C.pullToRefreshTitle)
        refreshControl.addTarget(self, action: #selector(performPullToRefreshAction),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func performPullToRefreshAction() {
        activityIndicatorView.startAnimating()
        obtainFreshPosts()
    }
    
    private func obtainNextPosts() {
        model?.obtainTopPosts(isInitial: false) { [weak self] posts, isSuccess in
            
            guard let self = self else {
                return
            }
            
            self.isLoadingNextPosts = false
            self.activityIndicatorView.stopAnimating()
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            if isSuccess {
                var paths: [IndexPath] = []
                for (idx, _) in posts.enumerated() {
                    paths.append(.init(row: self.posts.count + idx, section: 0))
                }
                
                self.posts.append(contentsOf: posts)
                self.tableView.insertRows(at: paths, with: .automatic)
                self.model?.savePosts(self.posts)
            }
        }
    }
}
 
// MARK: - UITableViewDataSource
extension TopPostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellReuseIdentifier,
                                                 for: indexPath) as! TopPostTableViewCell
        let post = posts[indexPath.row]
        let hoursCreatedAgo = Int((Date().timeIntervalSince1970 - post.created) / 60 / 60)
        cell.configure(using: .init(title: post.title,
                                    author: "by \(post.author)",
                                    time: "\(hoursCreatedAgo) hours ago",
                                    imageURL: post.thumbnail,
                                    commentsCount: "\(post.numberComments)"))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TopPostsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.openTopPost(using: posts[indexPath.row].url)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoadingNextPosts && posts.count > 0 else {
            return
        }
        
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            isLoadingNextPosts = true
            activityIndicatorView.startAnimating()
            obtainNextPosts()
        }
    }
}
