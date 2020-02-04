//
//  ApplicationCoordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var window: UIWindow?
    let rootViewController: UINavigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = AdvertisementsViewModel()
        viewModel.delegate = self
        let advertisementsListViewController = AdvertisementsListViewController(viewModel: viewModel)
        rootViewController.pushViewController(advertisementsListViewController, animated: false)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}

extension ApplicationCoordinator: AdvertisementsViewModelDelegate {
    func didTapFilter(viewModel: AdvertisementsViewModelProtocol) {
        
    }
    
    func didTapAdvertisement(viewModel: AdvertisementsViewModelProtocol) {
        
    }
    
    
}
