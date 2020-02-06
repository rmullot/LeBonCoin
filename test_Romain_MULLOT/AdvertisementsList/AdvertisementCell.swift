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
        let currentUrl = viewModel.getThumbImage(index: index)
        photoView.loadImage(urlString: currentUrl, placeHolder: UIImage(named:"placeholder"), completionHandler: { [ weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let image, let urlString):
                    if currentUrl == urlString {
                        strongSelf.photoView.image = image
                    } else {
                        strongSelf.photoView.image = UIImage(named:"placeholder")
                    }
                case .failure(_): break
                }
        })
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
        let defaultMargin: CGFloat = 10
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: defaultMargin),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultMargin),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultMargin),
            photoView.widthAnchor.constraint(equalToConstant: 95),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: defaultMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: 53),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: defaultMargin),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            priceLabel.heightAnchor.constraint(equalToConstant: 25),
            
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultMargin),
            categoryLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: defaultMargin),
            categoryLabel.trailingAnchor.constraint(equalTo: urgencyIcon.leadingAnchor, constant: -defaultMargin),
            categoryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            urgencyIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultMargin),
            urgencyIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            urgencyIcon.widthAnchor.constraint(equalToConstant: 20),
            urgencyIcon.heightAnchor.constraint(equalTo: urgencyIcon.widthAnchor)
        ])
    }
}
