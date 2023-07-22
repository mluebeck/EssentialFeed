//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Mario Rotz on 22.07.23.
//

import UIKit 

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
