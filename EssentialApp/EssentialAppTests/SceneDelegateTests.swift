//
//  SceneDelegateTests.swift
//  EssentialAppTests
//
//  Created by Mario Rotz on 12.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import XCTest
@testable import EssentialApp
import EssentialFeediOS

class SceneDelegateTests : XCTestCase {
    
    func test_sceneWillConnectToSession_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        sut.configureWindow()

        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing:root)) instead")
        XCTAssertTrue(topController is FeedViewController, "Expected a fee controller as top view controller, got \(String(describing: topController)) instead")
        XCTAssertTrue(sut.window?.rootViewController is UINavigationController)
    }
}