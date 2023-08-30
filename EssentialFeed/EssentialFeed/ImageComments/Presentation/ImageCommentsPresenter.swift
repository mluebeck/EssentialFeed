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

    public static func map(
            _ comments: [ImageComment],
            currentDate: Date = Date(),
            calendar: Calendar = .current,
            locale: Locale = .current
        ) -> ImageCommentsViewModel {
            let formatter = RelativeDateTimeFormatter()
            formatter.calendar = calendar
            formatter.locale = locale

            return ImageCommentsViewModel(comments: comments.map { comment in
                ImageCommentViewModel(
                    message: comment.message,
                    date: formatter.localizedString(for: comment.createdAt, relativeTo: currentDate),
                    username: comment.author_username)
            })

    }
}
