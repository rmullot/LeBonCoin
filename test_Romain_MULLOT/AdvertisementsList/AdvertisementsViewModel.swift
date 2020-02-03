//
//  AdvertisementsViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol AdvertisementsViewModelProtocol {
    var advertisementsCount: Int { get }
    func getIsNotUrgent(index: Int) -> Bool
    func getPrice(index: Int) -> String
    func getTitle(index: Int) -> String
    func getCategory(index: Int) -> String
}

final class AdvertisementsViewModel: AdvertisementsViewModelProtocol {
    
    var advertisementsCount: Int {
        return 12
    }
    
    func getIsNotUrgent(index: Int) -> Bool {
        return false
    }
    
    func getPrice(index: Int) -> String {
        return "23$"
    }
    
    func getTitle(index: Int) -> String {
        return "test"
    }
    
    func getCategory(index: Int) -> String {
        return "category"
    }
    
}
