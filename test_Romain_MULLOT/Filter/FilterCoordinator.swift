//
//  FilterCoordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

protocol FilterCoordinatorDelegate: AnyObject {
    
}

final class FilterCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    let rootViewController: UINavigationController = UINavigationController()
    
    init() {
        
    }
    
    func start() {
        let viewModel = FilterViewModel()
        viewModel.delegate = self
        let filterViewController = FilterViewController(viewModel: viewModel)
        rootViewController.pushViewController(filterViewController, animated: true)
    }
    
}

extension FilterCoordinator: FilterViewModelDelegate {
    func didTapCancel(viewModel: FilterViewModelProtocol) {
        
    }
    
    func didTapValidate(viewModel: FilterViewModelProtocol) {
        
    }
    
    
}
