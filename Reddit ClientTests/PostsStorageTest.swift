//
//  PostsStorageTest.swift
//  Reddit ClientTests
//
//  Created by Anna on 16.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import XCTest
@testable import Reddit_Client

class PostsStorageTest: XCTestCase {

    var sut: PostsStorageType!
    let postToSave: Post = .init(id: "123",
                                 fullServerID: "t3_2323",
                                 title: "Test Post",
                                 author: "Clone",
                                 thumbnail: URL(string: "default")!,
                                 created: 1600250529.0,
                                 numberComments: 13,
                                 url: URL(string: "default")!)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = PostsStorage()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_SavingPosts() throws {
        try sut.save(posts: [.init(id: postToSave.id,
                                   fullServerID: postToSave.fullServerID,
                                   title: postToSave.title,
                                   author: postToSave.author,
                                   thumbnail: postToSave.thumbnail,
                                   created: postToSave.created,
                                   numberComments: postToSave.numberComments,
                                   url: postToSave.url)])
    }
    
    func test_LoadingPosts() throws {
        let loadedPosts = try sut.load()
        XCTAssertEqual(loadedPosts.count, 1)
        XCTAssertEqual(loadedPosts[0].fullServerID, postToSave.fullServerID)
    }
}
