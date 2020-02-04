//
//  Coordinator.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    
    func addChildCoordinator(_ coordinator: Coordinator) { childCoordinators.append(coordinator)
    }
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ !($0 === coordinator) })
    }
    
}
