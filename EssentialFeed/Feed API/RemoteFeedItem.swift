//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 18.06.23.
//

import Foundation

 struct RemoteFeedItem : Decodable {
     let id : UUID
     let description : String?
     let location : String?
     let image : URL
}
