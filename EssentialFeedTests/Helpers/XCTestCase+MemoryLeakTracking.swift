//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 02.06.23.
//

import XCTest

extension XCTestCase {
    public func trackForMemoryLeaks(_ instance: AnyObject, file:StaticString = #file, line:UInt = #line) {
        addTeardownBlock {
            [weak instance] in
            XCTAssertNil(instance,"Instance should have been deallocated. Potential memory leak",file:file, line:line)
        }
    }
}
