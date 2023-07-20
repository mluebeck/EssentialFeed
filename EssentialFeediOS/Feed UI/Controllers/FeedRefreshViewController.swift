//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 17.07.23.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRequest()
}

final class FeedRefreshViewController : NSObject , FeedLoadingView {
    private(set) lazy var view = loadView()

    private let delegate: FeedRefreshViewControllerDelegate
    
    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
    }
 
    @objc func refresh() {
        delegate.didRequestFeedRequest()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
