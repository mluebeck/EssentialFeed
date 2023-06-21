//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 21.06.23.
//

import XCTest
import EssentialFeed

class ValidateFeedCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedMessages,[])
    }
    
    func test_validateCache_deletesCacheOnRetrievalError() {
        let (sut,store) = makeSUT()
        sut.validateCache()
        store.completeRetrieval(with: anyNSError())
        XCTAssertEqual(store.receivedMessages, [.retrieve,.deleteCachedFeed])
    }
    
    func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
        let (sut,store) = makeSUT()
        sut.validateCache()
        store.completeRetrievalWithEmptyCache()
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_validateCache_doesNotDeleteLessThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let lessThanSevenDaysOldTime = fixedCurrentDate.adding(days: -7).adding(seconds: 1)
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.validateCache()
        store.completeRetrieval(with:feed.local, timestamp: lessThanSevenDaysOldTime )
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    
    
    func test_validateCache_deleteSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let sevenDaysOldTime = fixedCurrentDate.adding(days: -7)
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.validateCache()
        store.completeRetrieval(with:feed.local, timestamp: sevenDaysOldTime )
        XCTAssertEqual(store.receivedMessages, [.retrieve,.deleteCachedFeed])
    }
    
    func test_validateCache_deletesMoreThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let moreThansevenDaysOldTime = fixedCurrentDate.adding(days: -7).adding(seconds: -1)
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.validateCache()
        store.completeRetrieval(with:feed.local, timestamp: moreThansevenDaysOldTime )
        XCTAssertEqual(store.receivedMessages, [.retrieve,.deleteCachedFeed])
    }
    
    
    
    
    
    
    //MARK: Helpers

    private func makeSUT(currentDate: @escaping ()->Date = Date.init, file:StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store,file:file,line:line)
        trackForMemoryLeaks(sut,file:file,line:line)
        return (sut,store)
    }
    
}



