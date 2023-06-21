//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Mario Rotz on 21.06.23.
//

import Foundation

func anyNSError() -> NSError {
    let anyError = NSError(domain:"any error",code:0)
    return anyError
}

func anyURL() -> URL {
    return URL(string:"http://any-url.com")!
}

