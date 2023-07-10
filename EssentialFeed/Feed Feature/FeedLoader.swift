//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>


public protocol FeedLoader {
    func load(completition: @escaping (LoadFeedResult) -> Void )
}
