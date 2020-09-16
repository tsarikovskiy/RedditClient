//
//  PostsStorageType.swift
//  Reddit Client
//
//  Created by Anna on 16.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

protocol PostsStorageType {
    func save(posts: [Post]) throws
    func load() throws -> [Post] 
}
