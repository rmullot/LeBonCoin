//
//  ApplicationCoordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit
import LBCBridge

final class ApplicationCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    weak var window: UIWindow?
    let rootViewController: UINavigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = AdvertisementsViewModel(advertisementService: AdvertisementService.sharedInstance, categoryService: CategoryService.sharedInstance)
        viewModel.delegate = self
        let advertisementsListViewController = AdvertisementsListViewController(viewModel: viewModel)
        rootViewController.pushViewController(advertisementsListViewController, animated: false)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}

extension ApplicationCoordinator: AdvertisementsViewModelDelegate {
    func didTapFilter(viewModel: AdvertisementsViewModelProtocol) {
        let filterCoordinator = FilterCoordinator(rootViewController: rootViewController)
        filterCoordinator.delegate = self
        addChildCoordinator(filterCoordinator)
        filterCoordinator.start()
    }
    
    func didTapAdvertisement(advertisement: Advertisement) {
        let advertisementDescription = AdvertisementDescriptionCoordinator(rootViewController: rootViewController)
        advertisementDescription.delegate = self
        addChildCoordinator(advertisementDescription)
        advertisementDescription.start(advertisement: advertisement)
    }
}

extension ApplicationCoordinator: FilterCoordinatorDelegate {
    func didFinish(_ coordinator: FilterCoordinator) {
        removeChildCoordinator(coordinator)
    }
}

extension ApplicationCoordinator: AdvertisementDescriptionCoordinatorDelegate {
    func didFinish(_ coordinator: AdvertisementDescriptionCoordinator) {
        removeChildCoordinator(coordinator)
    }
}
