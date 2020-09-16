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
    private let postsStorage: PostsStorageType
    
    // MARK: - Lifecycle
    init(redditService: RedditServiceType, postsStorage: PostsStorageType) {
        self.redditService = redditService
        self.postsStorage = postsStorage
    }
    
}

// MARK: - TopPostsListModelInput
extension TopPostsListModel: TopPostsListModelInput {
    
    func obtainTopPosts(isInitial: Bool, completion: @escaping ([Post], Bool) -> Void) {
        redditService.obtainTopPosts(isInitialPage: isInitial) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(posts):
                    completion(posts, true)
                    
                case .failure:
                    completion([], false)
                }
            }
        }
    }
    
    func savePosts(_ posts: [Post]) {
        
        // Save on the background
        DispatchQueue.global(qos: .background).async {
            try? self.postsStorage.save(posts: posts)
        }
    }
    
    func loadArchivedPosts(completion: @escaping ([Post]) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let posts = try? self.postsStorage.load()
            
            DispatchQueue.main.async {
                completion(posts ?? [])
            }
        }
    }
    
}
