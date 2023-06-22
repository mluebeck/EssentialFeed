//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 22.06.23.
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    
    private static let calendar = Calendar(identifier: .gregorian)
 
    private static  var maxCachAgeInDays : Int {
        return 7
    }
    
    internal static func validate(_ timestamp : Date, against date:Date )->Bool  {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCachAgeInDays, to: timestamp) else { return false }
        return date < maxCacheAge
    }
}
