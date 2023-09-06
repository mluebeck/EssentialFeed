//
//  NullStore.swift
//  EssentialApp
//
//  Created by Mario Rotz on 06.09.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//


import Foundation
import EssentialFeed

class NullStore {}

extension NullStore : FeedStore {
    func deleteCachedFeed() throws {}
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}
}

extension NullStore : FeedImageDataStore {
    func retrieve() throws -> CachedFeed? { .none }
    func insert(_ data: Data, for url: URL) throws {}
    func retrieve(dataForURL url: URL) throws -> Data? { .none }
}
