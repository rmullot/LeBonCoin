//
//  AdvertisementDescriptionViewController.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit
import LBCUIKit

final class AdvertisementDescriptionViewController: UIViewController {
    
    private let viewModel: AdvertisementDescriptionViewModelProtocol
    
    private let paddingStackView: CGFloat = 20

    private lazy var scrollView: LBCScrollView = {
        let scrollView = LBCScrollView.autolayout()
        scrollView.backgroundColor = .white
        scrollView.accessibilityIdentifier = "AdvertisementDescriptionViewController_scrollView"
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView.autolayout()
        stackView.backgroundColor = .white
        stackView.accessibilityIdentifier = "AdvertisementDescriptionViewController_stackView"
        stackView.isOpaque = true
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: paddingStackView, bottom: 0, right: paddingStackView)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.autolayout()
        titleLabel.backgroundColor = .white
        titleLabel.accessibilityIdentifier = "AdvertisementDescriptionViewController_titleLabel"
        titleLabel.isOpaque = true
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel.autolayout()
        descriptionLabel.backgroundColor = .white
        descriptionLabel.accessibilityIdentifier = "AdvertisementDescriptionViewController_descriptionLabel"
        descriptionLabel.isOpaque = true
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel.autolayout()
        dateLabel.backgroundColor = .white
        dateLabel.accessibilityIdentifier = "AdvertisementDescriptionViewController_dateLabel"
        dateLabel.isOpaque = true
        dateLabel.textAlignment = .left
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel.autolayout()
        priceLabel.backgroundColor = .white
        priceLabel.accessibilityIdentifier = "AdvertisementDescriptionViewController_priceLabel"
        priceLabel.isOpaque = true
        priceLabel.textAlignment = .left
        priceLabel.textColor = .black
        priceLabel.numberOfLines = 0
        return priceLabel
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel.autolayout()
        categoryLabel.backgroundColor = .white
        categoryLabel.accessibilityIdentifier = "AdvertisementDescriptionViewController_categoryLabel"
        categoryLabel.isOpaque = true
        categoryLabel.textAlignment = .left
        categoryLabel.textColor = .black
        categoryLabel.numberOfLines = 0
        return categoryLabel
    }()
    
    private lazy var smallPhoto: UIImageView = {
        let smallPhoto = UIImageView.autolayout()
        smallPhoto.backgroundColor = .white
        smallPhoto.accessibilityIdentifier = "AdvertisementDescriptionViewController_smallPhoto"
        smallPhoto.isOpaque = true
        smallPhoto.contentMode = .scaleAspectFit
        return smallPhoto
    }()
    
    private lazy var urgencyIcon: UIImageView = {
        let urgencyIcon = UIImageView.autolayout()
        urgencyIcon.backgroundColor = .clear
        urgencyIcon.accessibilityIdentifier = "AdvertisementDescriptionViewController_urgencyIcon"
        urgencyIcon.isOpaque = true
        urgencyIcon.image = UIImage(named: "bell")
        return urgencyIcon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    init(viewModel: AdvertisementDescriptionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AdvertisementDescriptionViewController {
    
    @objc
    func didTapBackButton(_ sender: UIButton) {
        viewModel.didTapBack()
    }
}

private extension AdvertisementDescriptionViewController {
    
    func setup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: .didTapBackButton)
        edgesForExtendedLayout = []
        view.isOpaque = true
        view.backgroundColor = .white
        setupInterface()
        setupConstraints()
        config()
    }
    
    func setupInterface() {
        view.addSubview(scrollView)
        scrollView.addSubview(smallPhoto)
        smallPhoto.addSubview(urgencyIcon)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        scrollView.anchorToBounds(view: view)
        NSLayoutConstraint.activate([
            smallPhoto.topAnchor.constraint(equalTo: scrollView.topAnchor),
            smallPhoto.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            smallPhoto.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            smallPhoto.heightAnchor.constraint(equalToConstant: 200),
            
            urgencyIcon.bottomAnchor.constraint(equalTo: smallPhoto.bottomAnchor, constant: -10),
            urgencyIcon.trailingAnchor.constraint(equalTo: smallPhoto.trailingAnchor, constant: -10),
            urgencyIcon.widthAnchor.constraint(equalToConstant: 20),
            urgencyIcon.heightAnchor.constraint(equalTo: urgencyIcon.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: smallPhoto.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func config() {
        urgencyIcon.isHidden = viewModel.isNotUrgent
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.creationDate
        descriptionLabel.text = viewModel.descriptionAdvertisement
        categoryLabel.text = viewModel.category
        let currentUrl = viewModel.smallPhotoUrl
        smallPhoto.loadImage(urlString: currentUrl, placeHolder: UIImage(named:"placeholder"), completionHandler: { [ weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let image, let urlString):
                    if currentUrl == urlString {
                        strongSelf.smallPhoto.image = image
                    } else {
                        strongSelf.smallPhoto.image = UIImage(named:"placeholder")
                    }
                case .failure(_): break
                }
        })
        loadViewIfNeeded()
    }
}

private extension Selector {
    static let didTapBackButton = #selector(AdvertisementDescriptionViewController.didTapBackButton(_:))
}
