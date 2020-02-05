//
//  Category.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCCoreData

final class Category {
    
    let idCategory: Int
    let name: String
    
    init(idCategory: Int = 0, name: String = "") {
        self.idCategory = idCategory
        self.name = name
    }
    
    init(category: CategoryCoreData) {
        idCategory = Int(category.idCategory)
        name = category.name
    }
    
}
