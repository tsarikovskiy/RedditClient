//
//  RedditServiceType.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

protocol RedditServiceType {
    
    /// Request for top post
    /// - Parameters:
    ///   - isInitialPage: Is load first page
    ///   - completion: Return post items or error  while loading these items
    func obtainTopPosts(isInitialPage: Bool, completion: @escaping (Result<[Post], APIError>) -> Void)
}
