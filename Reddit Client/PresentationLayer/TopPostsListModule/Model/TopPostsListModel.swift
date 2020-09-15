//
//  TopPostsListModel.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

final class TopPostsListModel {
    
    // MARK: - Properties
    private let redditService: RedditServiceType
    
    // MARK: - Lifecycle
    init(redditService: RedditServiceType) {
        self.redditService = redditService
    }
    
}

// MARK: - TopPostsListModelInput
extension TopPostsListModel: TopPostsListModelInput {
    
    func obtainTopPosts() {
        redditService.obtainTopPosts { result in
            switch result {
            case let .success(posts):
                break
                
            case let .failure(error):
                break
            }
        }
    }
}
