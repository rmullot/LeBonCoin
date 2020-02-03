//
//  AdvertisementCell.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

final class AdvertisementCell: UITableViewCell {
    
    private lazy var photoView: UIImageView = {
        let photoView = UIImageView.autolayout()
        photoView.backgroundColor = .white
        photoView.accessibilityIdentifier = "AdvertisementCell_photoView"
        photoView.isOpaque = true
        return photoView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel.autolayout()
        categoryLabel.backgroundColor = .white
        categoryLabel.accessibilityIdentifier = "AdvertisementCell_categoryLabel"
        categoryLabel.isOpaque = true
        return categoryLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.autolayout()
        titleLabel.backgroundColor = .white
        titleLabel.accessibilityIdentifier = "AdvertisementCell_titleLabel"
        titleLabel.isOpaque = true
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel.autolayout()
        priceLabel.backgroundColor = .white
        priceLabel.accessibilityIdentifier = "AdvertisementCell_priceLabel"
        priceLabel.isOpaque = true
        return priceLabel
    }()
    
    private lazy var urgencyIcon: UIImageView = {
        let urgencyIcon = UIImageView.autolayout()
        urgencyIcon.backgroundColor = .white
        urgencyIcon.accessibilityIdentifier = "AdvertisementCell_urgencyIcon"
        urgencyIcon.isOpaque = true
        urgencyIcon.image = UIImage(named: "bell")
        return urgencyIcon
    }()
    
    func config(viewModel: AdvertisementsViewModelProtocol, index: Int) {
        urgencyIcon.isHidden = viewModel.getIsNotUrgent(index: index)
        titleLabel.text = viewModel.getTitle(index: index)
        priceLabel.text = viewModel.getPrice(index: index)
        categoryLabel.text = viewModel.getCategory(index: index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        categoryLabel.text = ""
        titleLabel.text = ""
        priceLabel.text = ""
        urgencyIcon.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
}

private extension AdvertisementCell {
    
    func setup() {
        isOpaque = true
        translatesAutoresizingMaskIntoConstraints = true
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        addSubview(photoView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(categoryLabel)
        addSubview(urgencyIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoView.widthAnchor.constraint(equalToConstant: 95),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 25),
            
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            categoryLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: urgencyIcon.leadingAnchor, constant: -10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            urgencyIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            urgencyIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            urgencyIcon.widthAnchor.constraint(equalToConstant: 20),
            urgencyIcon.heightAnchor.constraint(equalTo: urgencyIcon.widthAnchor)
        ])
    }
}
