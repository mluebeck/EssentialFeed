//
//  FeedImageCell.swift
//  Prototype
//
//  Created by Mario Rotz on 14.07.23.
//

import UIKit

final class FeedImageCell : UITableViewCell {
    @IBOutlet private(set) var locationContainer: UIView!
    @IBOutlet private(set) var locationLabel: UILabel!
    @IBOutlet private(set) var feedImageView: UIImageView!
    @IBOutlet private(set) var descriptionLabel: UILabel!
}
