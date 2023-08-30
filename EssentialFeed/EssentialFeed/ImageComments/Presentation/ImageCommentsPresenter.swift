//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Mario Rotz on 30.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import Foundation

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString(
            "IMAGECOMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: ImageCommentsPresenter.self),
            comment: "Title for the image comments view")
    }

    public static func map(_ imageComments: [ImageComment]) -> ImageCommentsModel {
        ImageCommentsModel(imageComments: imageComments)
    }
}
