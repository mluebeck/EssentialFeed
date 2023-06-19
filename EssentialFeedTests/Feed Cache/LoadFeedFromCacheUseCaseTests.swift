//
//  LoadFeedFromCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 19.06.23.
//

import XCTest
import EssentialFeed

final class LoadFeedFromCacheUseCaseTests: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedMessages,[])
    }
    
    func test_load_requestCacheRetrieval() {
        let (sut, store) = makeSUT()
        sut.load { _ in }
        XCTAssertEqual(store.receivedMessages,[.retrieve ])
    }
    
    func test_load_failsOnRetrievealError() {
        let (sut, store) = makeSUT()
        let exp = expectation(description: "Wait fo load completion")
        let retrievalError =  anyNSError()
        var receivedError : Error?
        sut.load { result in
            switch result {
            case let .failure(error):
                receivedError = error
            default:
                XCTFail("Expected failure, got \(result) instead")
            }
            exp.fulfill()
        }
        store.completeRetrieval(with:retrievalError)
        wait(for: [exp] , timeout: 1.0)
        XCTAssertEqual(receivedError as NSError?,retrievalError)
    }
    
     
    func test_load_deliversNoImageOnEmptyCache() {
        let (sut, store) = makeSUT()
        let exp = expectation(description: "Wait fo load completion")
        var receivedImages : [FeedImage]?
        sut.load { result in
            switch result {
            case let .success(images):
                receivedImages = images
            default:
                XCTFail("Expected success, got \(result) instead")
            }
            exp.fulfill()
        }
        store.completeRetrievalWithEmptyCache()
        wait(for: [exp] , timeout: 1.0)
        XCTAssertEqual(receivedImages,[])
    }
   
    
    
    
    //MARK: Helper Methods
    private func anyNSError() -> NSError {
        let anyError = NSError(domain:"any error",code:0)
        return anyError
    }
    private func makeSUT(currentDate: @escaping ()->Date = Date.init, file:StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store,file:file,line:line)
        trackForMemoryLeaks(sut,file:file,line:line)
        return (sut,store)
    }
    
    
}
