//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation



public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    func load(completition: @escaping (Result) -> Void )
}
