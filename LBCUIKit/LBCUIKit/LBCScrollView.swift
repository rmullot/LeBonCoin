//
//  LBCScrollView.swift
//  LBCUIKit
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

public class LBCScrollView: UIScrollView {
    
    private var currentKeyboardHeight: CGFloat = .zero
    
    public lazy var contentView: UIView = {
        let contentView = UIView.autolayout()
        contentView.backgroundColor = backgroundColor
        contentView.accessibilityIdentifier = "LBCScrollView_ContentView"
        contentView.isOpaque = true
        return contentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public var backgroundColor: UIColor? {
        didSet {
            contentView.backgroundColor = backgroundColor
        }
    }
    
    
}
private extension LBCScrollView {
    
    func setup() {
        isOpaque = true
        contentInsetAdjustmentBehavior = .never
        contentInset = .zero
        scrollIndicatorInsets = .zero
        translatesAutoresizingMaskIntoConstraints = false
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        addSubview(contentView)
    }
    
    func setupConstraints() {
        contentView.setVerticalContentPriority(.defaultLow)
        let bottomContentViewConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        bottomContentViewConstraint.priority = UILayoutPriority.defaultLow
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: widthAnchor), contentView.topAnchor.constraint(equalTo: topAnchor), contentView.leftAnchor.constraint(equalTo: leftAnchor), contentView.rightAnchor.constraint(equalTo: rightAnchor), contentView.bottomAnchor.constraint(equalTo: bottomAnchor), bottomContentViewConstraint,
        ])
    }
}
