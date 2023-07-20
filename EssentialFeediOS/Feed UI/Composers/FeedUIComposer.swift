//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 17.07.23.
//
import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = refreshController
        presenter.feedView = FeedViewAdapter(controller:feedController,imageLoader: imageLoader)
        return feedController
   }
    
    
}

private final class FeedViewAdapter : FeedView {
    private weak var controller : FeedViewController?
    private let imageLoader : FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader : FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(feed: [EssentialFeed.FeedImage]) {
        controller?.tableModel = feed.map { model in
            FeedImageCellController(viewModel:
                                FeedImageViewModel(model: model,
                                                   imageLoader: imageLoader,
                                                   imageTransformer: UIImage.init))
        }
    }
}