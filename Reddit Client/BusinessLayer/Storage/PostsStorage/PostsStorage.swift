//
//  PostsStorage.swift
//  Reddit Client
//
//  Created by Anna on 16.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

struct PostsStorage {
    
    // MARK: - CRUD errors
    enum SaveError: Error {
        case errorSavingPosts
        case errorLoadingPosts
    }
    
    // MARK: - URLs To File Storage
    private static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let ArchiveURL = DocumentsDirectory.appendingPathComponent("posts")
}

// MARK: - PostsStorageType
extension PostsStorage: PostsStorageType {
    
    func load() throws -> [Post] {
        
        guard let archivedData = try? Data(contentsOf: Self.ArchiveURL) else {
            throw SaveError.errorLoadingPosts
        }
        
        do {
            let archivedPosts = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData) as? [ArchivedPost]
            let posts = archivedPosts?
                .compactMap { Post(id: $0.id,
                                   fullServerID: $0.fullServerID,
                                   title: $0.title,
                                   author: $0.author,
                                   thumbnail: $0.thumbnail,
                                   created: $0.created,
                                   numberComments: $0.numberComments,
                                   url: $0.url) }
            return posts ?? []
            
        } catch {
            
            throw SaveError.errorLoadingPosts
            
        }

    }
    
    func save(posts: [Post]) throws {
        let arhivedPosts = posts
            .compactMap { ArchivedPost(id: $0.id,
                                       fullServerID: $0.fullServerID,
                                       title: $0.title,
                                       author: $0.author,
                                       thumbnail: $0.thumbnail,
                                       created: $0.created,
                                       numberComments: $0.numberComments,
                                       url: $0.url)
        }

        do {
            
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: arhivedPosts, requiringSecureCoding: false)
            try archivedData.write(to: Self.ArchiveURL)
            
        } catch {
            
            throw SaveError.errorSavingPosts
            
        }
    }
}
