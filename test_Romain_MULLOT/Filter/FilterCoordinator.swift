//
//  FilterCoordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit
import LBCBridge

//TODO: To do the difference between cancel and validate filters
protocol FilterCoordinatorDelegate: AnyObject {
    func didFinish(_ coordinator: FilterCoordinator)
}

final class FilterCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var rootViewController: UINavigationController?
    weak var delegate: FilterCoordinatorDelegate?
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = FilterViewModel(categoryService: CategoryService.sharedInstance)
        viewModel.delegate = self
        let filterViewController = FilterViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: filterViewController)
        navigationController.modalPresentationStyle = .fullScreen
        rootViewController?.present(navigationController, animated: true)
    }
    
}

extension FilterCoordinator: FilterViewModelDelegate {
    
    func didTapCancel(viewModel: FilterViewModelProtocol) {
        if let navigationController = rootViewController {
            navigationController.dismiss(animated: true)
        }
        delegate?.didFinish(self)
    }
    
    func didTapValidate(viewModel: FilterViewModelProtocol) {
        if let navigationController = rootViewController {
            navigationController.dismiss(animated: true)
        }
        delegate?.didFinish(self)
    }
    
}


