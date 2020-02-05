//
//  CoreDataService+Advertisement.swift
//  LBCCoreData
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCAPI

public protocol AdvertisementsCoreDataServiceProtocol: AnyObject {
    func savesCategoriesJSON(_ categories: [CategoryJSON])
}


