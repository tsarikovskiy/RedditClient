//
//  RedditServiceType.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

protocol RedditServiceType {
    func obtainTopPosts(completion: @escaping (Result<[Post], APIError>) -> Void)
}
