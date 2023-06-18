//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 17.06.23.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?)->Void
    typealias InsertionCompletion = (Error?)->Void

    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [LocalFeedItem],timestamp:Date,completion: @escaping InsertionCompletion)
}


