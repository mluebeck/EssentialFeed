//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 07.08.23.
//

public struct FeedErrorViewModel {
    public let message: String?
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
