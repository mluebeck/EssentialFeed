//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation
public final class RemoteFeedLoader {
    private let url : URL
    private let client : HTTPClient
    
    public enum Error : Swift.Error {
        case  connectivity
    }
    public init(url: URL = URL(string:"https://a-url.com")!, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load( completion: @escaping (Error)-> Void = { _ in }) {
        client.get(from: url) {
            error in
            completion(.connectivity)
            
        }
    }
}

public protocol HTTPClient {
    func get(from url:URL, completion: @escaping (Error) -> Void)
}
