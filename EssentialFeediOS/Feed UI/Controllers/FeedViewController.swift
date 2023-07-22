//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 16.07.23.
//

import UIKit
 
protocol FeedViewControllerDelegate {
    func didRequestFeedRequest()
}

final public class FeedViewController : UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView {
      
    var delegate : FeedViewControllerDelegate?
    
    var tableModel = [FeedImageCellController]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            refreshControl?.beginRefreshing()
        } else {
            refreshControl?.endRefreshing()
        }
    }
    
    @IBAction private func refresh() {
        delegate?.didRequestFeedRequest()
    }
    
   
    //MARK: - View Controller life cycle 
    
     
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = FeedPresenter.title
        refresh()
    }
    
    //MARK: - TableView Delegates and Datasource

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        canceCellControllerLoad(forRowAt: indexPath)
    }
    
    //MARK: - prefetching
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(canceCellControllerLoad)
    }
    
    //MARK: - Cell Controller Methods
    
    private func cellController(forRowAt indexPath:IndexPath)-> FeedImageCellController {
        return tableModel[indexPath.row]
    }
    
    private func canceCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt:indexPath).cancelLoad()
    }
    
    
}
