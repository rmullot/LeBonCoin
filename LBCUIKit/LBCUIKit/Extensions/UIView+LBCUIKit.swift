//
//  UIView+LBCUIKit.swift
//  LBCUIKit
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    static func autolayout() -> Self {
        let view = Self()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setVerticalContentPriority(_ priority: UILayoutPriority) {
        setContentHuggingPriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .vertical)
    }
    
    func setHorizontalalContentPriority(_ priority: UILayoutPriority) {
        setContentHuggingPriority(priority, for: .horizontal)
        setContentCompressionResistancePriority(priority, for: .horizontal)
    }
}
