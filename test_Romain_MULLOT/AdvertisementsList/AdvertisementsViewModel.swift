//
//  AdvertisementsViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol AdvertisementsViewModelProtocol: AnyObject {
    var advertisementsCount: Int { get }
    func getIsNotUrgent(index: Int) -> Bool
    func getPrice(index: Int) -> String
    func getTitle(index: Int) -> String
    func getCategory(index: Int) -> String
    func didTapFilter()
    func didTapAdvertisement(index: Int)
    var delegate: AdvertisementsViewModelDelegate? { get set }
}

protocol AdvertisementsViewModelDelegate: AnyObject {
    func didTapFilter(viewModel: AdvertisementsViewModelProtocol)
    func didTapAdvertisement(viewModel: AdvertisementDescriptionViewModelProtocol)
}

final class AdvertisementsViewModel: AdvertisementsViewModelProtocol {
    
    weak var delegate: AdvertisementsViewModelDelegate?
    
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
    
    func didTapFilter() {
        delegate?.didTapFilter(viewModel: self)
    }
    
    func didTapAdvertisement(index: Int) {
        //TODO: to replace by the good viewModel
        guard index > 0, index < 1 else { return }
        let descriptionViewModel = getAdvertisementDescriptionViewModel(index: index)
        delegate?.didTapAdvertisement(viewModel: descriptionViewModel)
    }
    
}

private extension AdvertisementsViewModel {
    
    func getAdvertisementDescriptionViewModel(index: Int) -> AdvertisementDescriptionViewModelProtocol {
        return AdvertisementDescriptionViewModel()
    }
}
