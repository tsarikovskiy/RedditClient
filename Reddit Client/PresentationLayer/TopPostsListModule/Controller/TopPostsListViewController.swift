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
    }
    
    // MARK: - Outlets
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    var model: TopPostsListModelInput?
    var router: TopPostsListRouterInput?
    private var posts: [Post] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = C.title
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        model?.obtainTopPosts { [weak self] posts, isSuccess in
            self?.activityIndicatorView.stopAnimating()
            if isSuccess {
                self?.posts = posts
                self?.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "TopPostTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TopCell")
    }


}
 
// MARK: - UICollectionViewDataSource
extension TopPostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell",
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
        router?.openTopPost()
        print("*** click image URL = \(posts[indexPath.row].thumbnail)")
    }
}
