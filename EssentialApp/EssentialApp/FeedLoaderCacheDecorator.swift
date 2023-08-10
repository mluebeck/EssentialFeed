//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Mario Rotz on 10.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import EssentialFeed

public final class FeedLoaderCacheDecorator : FeedLoader {
    private let decoratee: FeedLoader
    private let cache : FeedCache
    
    public init(decoratee: FeedLoader,cache:FeedCache) {
        self.decoratee = decoratee
        self.cache=cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            completion(result.map { feed in
                self?.cache.save(feed) { _ in }
                return feed
            })
        }
    }
}
