//
//  RedditService.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

struct RedditService: RedditServiceType {
    
    func obtainTopPosts(completion: @escaping (Result<[Post], APIError>) -> Void) {
                
        guard let url = URL(string: "https://www.reddit.com/top.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let list = try JSONDecoder().decode(PostsList.self, from: data)
                    completion(.success(list.posts))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            } else {
                completion(.failure(.emptyResponse))
            }
        }.resume()
    }
}
