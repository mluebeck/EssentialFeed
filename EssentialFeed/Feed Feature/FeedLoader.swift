//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation

public enum LoadFeedResult  {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completition: @escaping (LoadFeedResult) -> Void )
}
