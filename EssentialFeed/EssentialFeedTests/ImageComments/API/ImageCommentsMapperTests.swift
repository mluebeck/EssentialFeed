//
//  ImageCommentsMapperTests.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 30.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 301, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try ImageCommentsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_map_throwsErrorOn2xxHTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        try (200 ... 299).forEach {
            XCTAssertThrowsError(
                try ImageCommentsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: $0))
            )
        }
    }


    // MARK: - Helpers
    
    
    

    private func makeItem(id: UUID, message: String, createdAt: (date: Date, iso8601String: String), author_username: String) -> (model: ImageComment, json: [String: Any])
    {
        let item = ImageComment(id: id, message: message, createdAt: createdAt.date, author_username: author_username)

        let json: [String: Any] = [
            "id": id.uuidString,
            "message": message,
            "created_at": createdAt.iso8601String,
            "author": [
                "username": author_username
            ]
        ]
        return (item, json)
    }
}


