//
//  ImageCommentCellController.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 05.09.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//


import UIKit
import EssentialFeed

public class ImageCommentCellController: NSObject, UITableViewDataSource {
     
    
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = model.message
        cell.usernameLabel.text = model.username
        cell.dateLabel.text = model.date
        return cell
    }
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {}
}
