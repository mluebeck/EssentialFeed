//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation

public enum LoadFeedResult<Error:Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable
{}

protocol FeedLoader {
    associatedtype Error : Swift.Error
    func load(completition: @escaping (LoadFeedResult<Error>) -> Void )
}
