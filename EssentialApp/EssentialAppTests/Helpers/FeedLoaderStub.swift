//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Mario Rotz on 10.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import EssentialFeed

class  FeedLoaderStub:  FeedLoader {
    private let result: FeedLoader.Result
    
    init(result:FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completion(result)
    }
}
