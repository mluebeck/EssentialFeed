//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 10.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

public protocol FeedCache {
    typealias Result = Swift.Result<Void,Error>
    func save(_ feed: [FeedImage]) throws
}
