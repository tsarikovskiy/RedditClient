//
//  ArchivedPost.swift
//  Reddit Client
//
//  Created by Anna on 16.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

final class ArchivedPost: NSObject {
    
    // MARK: - Coding Keys
    enum Key {
        static let id = "id"
        static let fullServerID = "fullServerID"
        static let title = "title"
        static let author = "author"
        static let thumbnail = "thumbnail"
        static let created = "created"
        static let numberComments = "numberComments"
        static let url = "url"
    }
    
    // MARK: - Properties
    let id: String
    let fullServerID: String
    let title: String
    let author: String
    let thumbnail: URL
    let created: TimeInterval
    let numberComments: Int
    let url: URL
    
    // MARK: - Lifecycle
    init(id: String,
         fullServerID: String,
         title: String,
         author: String,
         thumbnail: URL,
         created: TimeInterval,
         numberComments: Int,
         url: URL) {
        
        self.id = id
        self.fullServerID = fullServerID
        self.title = title
        self.author = author
        self.thumbnail = thumbnail
        self.created = created
        self.numberComments = numberComments
        self.url = url
    }
}

// MARK: - NSCoding
extension ArchivedPost: NSCoding {
    
    // MARK: - Lifecycle
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: Key.id)
        coder.encode(fullServerID, forKey: Key.fullServerID)
        coder.encode(title, forKey: Key.title)
        coder.encode(author, forKey: Key.author)
        coder.encode(thumbnail, forKey: Key.thumbnail)
        coder.encode(created, forKey: Key.created)
        coder.encode(numberComments, forKey: Key.numberComments)
        coder.encode(url, forKey: Key.url)
    }
    
    convenience init?(coder: NSCoder) {
        
        guard let id = coder.decodeObject(forKey: Key.id) as? String,
            let fullServerID = coder.decodeObject(forKey: Key.fullServerID) as? String,
            let title = coder.decodeObject(forKey: Key.title) as? String,
            let author = coder.decodeObject(forKey: Key.author) as? String,
            let thumbnail = coder.decodeObject(forKey: Key.thumbnail) as? URL,
            let url = coder.decodeObject(forKey: Key.url) as? URL else {
                return nil
        }
        
        let created = coder.decodeDouble(forKey: Key.created)
        let numberComments = coder.decodeInteger(forKey: Key.numberComments)
        
        self.init(id: id,
                  fullServerID: fullServerID,
                  title: title,
                  author: author,
                  thumbnail: thumbnail,
                  created: created,
                  numberComments: numberComments,
                  url: url)
    }
}
