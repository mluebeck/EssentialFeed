//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 17.06.23.
//

import Foundation
public typealias  RetrieveCachedFeedResult  = Result<CachedFeed,Error>

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp:Date) 

public protocol FeedStore {
    typealias DeletionCompletion = (Error?)->Void
    typealias InsertionCompletion = (Error?)->Void
    
    typealias  RetrievalResult  = Result<CachedFeed?,Error>
    typealias RetrievalCompletion = (FeedStore.RetrievalResult)->Void
    
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedFeed(completion: @escaping DeletionCompletion)

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion )
    
}


