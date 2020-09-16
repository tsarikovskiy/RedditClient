//
//  TopPostsListAssembly.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

struct TopPostsListAssembly {
    
    func makeController() -> UIViewController {
        let storyboard = UIStoryboard(name: "TopPostsListViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TopPostsListViewController
        
        let router = TopPostsListRouter()
        router.controller = vc
        
        vc.model = TopPostsListModel(redditService: RedditService(),
                                     postsStorage: PostsStorage())
        vc.router = router
        
        return vc
    }
}
