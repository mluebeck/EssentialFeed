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
    @IBOutlet private var view : UIRefreshControl?
    var delegate : FeedRefreshViewControllerDelegate?
 
    @IBAction func refresh() {
        delegate?.didRequestFeedRequest()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
     
}
