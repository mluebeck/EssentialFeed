//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 06.08.23.
//

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
