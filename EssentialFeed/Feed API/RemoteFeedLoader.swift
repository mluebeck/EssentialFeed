//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation


public final class RemoteFeedLoader : FeedLoader  {
    private let url : URL
    private let client : HTTPClient
    
    public enum Error : Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult
     
    public init(url: URL = URL(string:"https://a-url.com")!, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load( completition completion: @escaping (Result)-> Void) {
        client.get(from: url) {
            [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data,response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
