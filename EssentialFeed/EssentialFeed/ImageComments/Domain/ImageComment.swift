//
//  ImageComment.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 30.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import Foundation

public struct ImageComment: Equatable {
    public let id: UUID
    public let message: String
    public let createdAt: Date
    public let author_username: String

    public init(id: UUID, message: String, createdAt: Date, author_username: String) {
        self.id = id
        self.message = message
        self.createdAt = createdAt
        self.author_username = author_username
    }
}
