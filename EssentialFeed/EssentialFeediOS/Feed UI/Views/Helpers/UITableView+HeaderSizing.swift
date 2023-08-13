//
//  UITableView+HeaderSizing.swift
//  EssentialFeediOS
//
//  Created by Mario Rotz on 13.08.23.
//  Copyright © 2023 Essential Developer. All rights reserved.
//

import UIKit

extension UITableView {
    func sizeTableHeaderToFit() {
        guard let header = tableHeaderView else { return }
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
