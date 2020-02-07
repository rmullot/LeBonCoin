//
//  AdvertisementDescriptionCoordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit
import LBCBridge

protocol AdvertisementDescriptionCoordinatorDelegate: AnyObject {
    func didFinish(_ coordinator: AdvertisementDescriptionCoordinator)
}

final class AdvertisementDescriptionCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var rootViewController: UINavigationController?
    weak var delegate: AdvertisementDescriptionCoordinatorDelegate?
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start(advertisement: Advertisement) {
        let viewModel = AdvertisementDescriptionViewModel(advertisement: advertisement)
        viewModel.delegate = self
        let advertisementDescriptionViewController = AdvertisementDescriptionViewController(viewModel: viewModel)
        rootViewController?.pushViewController(advertisementDescriptionViewController, animated: true)
    }
}

extension AdvertisementDescriptionCoordinator: AdvertisementDescriptionViewModelDelegate {
    func didTapBack() {
        if let navigationController = rootViewController {
            navigationController.popViewController(animated: true)
        }
        delegate?.didFinish(self)
    }
}


