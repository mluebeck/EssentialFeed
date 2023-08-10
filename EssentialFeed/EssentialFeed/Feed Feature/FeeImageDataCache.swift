//
//  FeeImageDataCache.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 10.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//


import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
