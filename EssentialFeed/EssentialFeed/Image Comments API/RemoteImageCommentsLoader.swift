//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 01.09.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

 
import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
