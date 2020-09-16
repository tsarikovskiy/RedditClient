//
//  RedditService.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

final class RedditService {

    // MARK: - Propereties
    var lastLoadedPostId = ""
    
}

// MARK: - RedditServiceType
extension RedditService: RedditServiceType {
    
    func obtainTopPosts(isInitialPage: Bool, completion: @escaping (Result<[Post], APIError>) -> Void) {
        
        // Create the URL
        var urlComponents = URLComponents(string: "https://www.reddit.com/top.json")
        
        // Add limit items query
        var queryItems = [URLQueryItem(name: "limit", value: "25")]
        
        // Check is loading first page
        if !isInitialPage {
            
            // Did we loaded the previously page
            if !lastLoadedPostId.isEmpty {
                
                // Add pagination query
                queryItems.append(URLQueryItem(name: "after", value: lastLoadedPostId))
                
             }
            
        }
                
        // Setup query to URL
        urlComponents?.queryItems = queryItems
        
        // Check for created URL
        guard let url = urlComponents?.url else {
            return
        }
        
        // Make request
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                error == nil else {
                    completion(.failure(.emptyResponse))
                    return
            }
                
            do {
                
                // Map response to models
                let list = try JSONDecoder().decode(PostsList.self, from: data)
                
                // Call the completion
                completion(.success(list.posts))
                
                // Save last loaded post id for pagination
                self.lastLoadedPostId = list.posts.last?.fullServerID ?? ""
                
            } catch {
                
                completion(.failure(.invalidResponse))
                
            }
            
        }.resume()
    }
}
