//
//  ImageCommentsViewModel.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 30.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

public struct ImageCommentsViewModel {
    public let comments: [ImageCommentViewModel]
}

public struct ImageCommentViewModel: Hashable {
    public let message: String
    public let date: String
    public let username: String

    public init(message: String, date: String, username: String) {
        self.message = message
        self.date = date
        self.username = username
    }
}
