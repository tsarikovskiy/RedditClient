//
//  TopPostsListViewController.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

class TopPostsListViewController: UIViewController {
    
    // MARK: - Properties
    var model: TopPostsListModelInput?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        model?.obtainTopPosts()
    }


}
