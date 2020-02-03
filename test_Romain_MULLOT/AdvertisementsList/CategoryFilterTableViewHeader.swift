//
//  CategoryFilterTableViewHeader.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

final class CategoryFilterTableViewHeader: UITableViewHeaderFooterView {
    
    lazy var filterButton: UIButton = {
        let filterButton = UIButton.autolayout()
        filterButton.backgroundColor = .orange
        filterButton.accessibilityIdentifier = "CategoryFilterTableViewHeader_filterButton"
        filterButton.setTitle("Filtre", for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.isOpaque = true
        filterButton.layer.cornerRadius = 15
        return filterButton
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
}

private extension CategoryFilterTableViewHeader {
    
    func setup() {
        isOpaque = true
        translatesAutoresizingMaskIntoConstraints = true
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        addSubview(filterButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            filterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
