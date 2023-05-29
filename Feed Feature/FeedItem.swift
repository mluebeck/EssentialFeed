//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 27.05.23.
//

import Foundation
 
public struct FeedItem : Equatable {
    let id : UUID
    let description : String?
    let location : String?
    let imageURL : URL
}
