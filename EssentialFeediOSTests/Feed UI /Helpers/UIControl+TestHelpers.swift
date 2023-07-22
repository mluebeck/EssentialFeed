//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Mario Rotz on 22.07.23.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
