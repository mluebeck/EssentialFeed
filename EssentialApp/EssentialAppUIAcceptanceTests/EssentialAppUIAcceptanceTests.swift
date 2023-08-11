//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by Mario Rotz on 11.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest

final class EssentialAppUIAcceptanceTests: XCTestCase {

    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity(){
        
        let app = XCUIApplication()
        
        app.launch()
        
        let feedCells = app.cells.matching(identifier:"feed-image-cell")
        XCTAssertEqual(feedCells.count, 22)
        
        let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
        XCTAssertTrue(firstImage.exists)
    
    }
}
