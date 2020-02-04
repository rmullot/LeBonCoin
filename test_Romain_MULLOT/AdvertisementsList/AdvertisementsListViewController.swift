//
//  AdvertisementsListViewController.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 01/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import UIKit
import LBCUIKit

final class AdvertisementsListViewController: UIViewController {
    
    private let advertisementHeightRow: CGFloat = 115
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.autolayout()
        tableView.backgroundColor = .white
        tableView.accessibilityIdentifier = "AdvertisementsListViewController_tableView"
        tableView.isOpaque = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = advertisementHeightRow
        tableView.registerReusableCell(AdvertisementCell.self)
        tableView.registerReusableView(CategoryFilterTableViewHeader.self)
        return tableView
    }()
    
    private let viewModel: AdvertisementsViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    init(viewModel: AdvertisementsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AdvertisementsListViewController {
    
    @objc
    func didTapFilterButton(_ sender: UIButton) {
        viewModel.didTapFilter()
    }
}

private extension AdvertisementsListViewController {
    
    func setup() {
        view.isOpaque = true
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AdvertisementsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return advertisementHeightRow
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension AdvertisementsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.advertisementsCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AdvertisementCell.self, indexPath: indexPath)
        cell.config(viewModel: viewModel, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableView(CategoryFilterTableViewHeader.self)
        header.filterButton.addTarget(self, action: .didTapFilterButton, for: .touchUpInside)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapFilter()
    }
    
}

private extension Selector {
    static let didTapFilterButton = #selector(AdvertisementsListViewController.didTapFilterButton(_:))
}
