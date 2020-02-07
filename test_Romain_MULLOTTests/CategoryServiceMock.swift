//
//  CategoryServiceMock.swift
//  test_Romain_MULLOTTests
//
//  Created by Romain Mullot on 07/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCBridge
@testable import test_Romain_MULLOT

final class CategoryServiceMock: CategoryServiceProtocol {
    func refreshCategories(completionHandler: @escaping (Result<[LBCBridge.Category]?, Error>) -> Void) {
        let category = LBCBridge.Category(idCategory: 7, name: "Livres/CD/DVD")
        return completionHandler(.success([category]))
    }
    
    func getCategories(completionHandler: @escaping (Result<[LBCBridge.Category]?, Error>) -> Void) {
        let category = LBCBridge.Category(idCategory: 7, name: "Livres/CD/DVD")
               return completionHandler(.success([category]))
    }
    
    
}
