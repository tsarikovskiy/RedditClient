//
//  Post.swift
//  Reddit Client
//
//  Created by Anna on 14.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import Foundation

struct Post: Identifiable {
    let id: String
    let title: String
    let author: String
    let thumbnail: URL
    let created: TimeInterval
    let numberComments: Int
}

// MARK: - Decodable
extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case data
        case title
        case author
        case thumbnail
        case created
        case numComments = "num_comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        thumbnail = try dataContainer.decode(URL.self, forKey: .thumbnail)
        created = try dataContainer.decode(TimeInterval.self, forKey: .created)
        numberComments = try dataContainer.decode(Int.self, forKey: .numComments)
    }
}
