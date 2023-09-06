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
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        completion(.success(()))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
}

extension NullStore : FeedImageDataStore {
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(.none))
    }
    
    func insert(_ data: Data, for url: URL) throws {}
 
    func retrieve(dataForURL url: URL) throws -> Data? { .none }

}
