//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 27.05.23.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL : URL?
}
final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }
    

}
