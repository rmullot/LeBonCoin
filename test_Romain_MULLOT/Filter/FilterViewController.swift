//
//  FilterViewController.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

final class FilterViewController: UIViewController {
    
    private let viewModel: FilterViewModelProtocol
    
    private let categoryHeightRow: CGFloat = 80
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.autolayout()
        tableView.backgroundColor = .white
        tableView.accessibilityIdentifier = "FilterViewController_tableView"
        tableView.allowsMultipleSelection = true
        tableView.isOpaque = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = categoryHeightRow
        tableView.registerReusableCell(CategoryCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
        viewModel.refreshCategoriesList { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
    
    init(viewModel: FilterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FilterViewController {
    
    func setup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: .didTapCancelButton)
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: .didTapValidateButton)
        navigationItem.rightBarButtonItem?.tintColor = .orange
        view.isOpaque = true
        view.backgroundColor = .white
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.anchorToBounds(view: view)
    }
}

extension FilterViewController {
    
    @objc
    func didTapCancelButton(_ sender: UIButton) {
        viewModel.didTapCancel()
    }
    
    @objc
    func didTapValidateButton(_ sender: UIButton) {
        viewModel.didTapValidate()
    }
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return categoryHeightRow
    }

}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CategoryCell.self, indexPath: indexPath)
        cell.config(viewModel: viewModel, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let categoryCell = cell as? CategoryCell else { return }
        categoryCell.config(viewModel: viewModel, index: indexPath.row)
//        if cell.isSelected {
//            cell.accessoryType = .checkmark
//            cell.isSelected = true
//            cell.layoutIfNeeded()
//        } else {
//            cell.accessoryType = .none
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCategory(index: indexPath.row)
    }
    
}

private extension Selector {
    static let didTapCancelButton = #selector(FilterViewController.didTapCancelButton(_:))
    static let didTapValidateButton = #selector(FilterViewController.didTapValidateButton(_:))
}
