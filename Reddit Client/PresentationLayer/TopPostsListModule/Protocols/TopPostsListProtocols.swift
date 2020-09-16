//
//  TopPostsListProtocols.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

protocol TopPostsListModelInput: class {
    /// Obtain top posts from reddit server
    /// - Parameters:
    ///   - isInitial: is initial obtaining
    ///   - completion: eturns array of posts and status of obtaining (true/false)
    func obtainTopPosts(isInitial: Bool, completion: @escaping ([Post], Bool) -> Void)
    
    /// Load archived posts from the previous session
    /// - Parameter completion: the array of archived posts
    func loadArchivedPosts(completion: @escaping ([Post]) -> Void)
    
    /// Save posts on disk
    /// - Parameter posts: posts to save
    func savePosts(_ posts: [Post])
}

protocol TopPostsListRouterInput: class {
    func openTopPost(using url: URL)
}
