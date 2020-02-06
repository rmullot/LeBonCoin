//
//  AdvertisementsViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCBridge
import LBCCore

protocol AdvertisementsViewModelProtocol: AnyObject {
    var advertisementsCount: Int { get }
    func getIsNotUrgent(index: Int) -> Bool
    func getPrice(index: Int) -> String
    func getTitle(index: Int) -> String
    func getCategory(index: Int) -> String
    func didTapFilter()
    func didTapAdvertisement(index: Int)
    func refreshAdvertisementList(completionHandler: @escaping ()->())
    init(advertisementService: AdvertisementService)
    var delegate: AdvertisementsViewModelDelegate? { get set }
}

protocol AdvertisementsViewModelDelegate: AnyObject {
    func didTapFilter(viewModel: AdvertisementsViewModelProtocol)
    func didTapAdvertisement(viewModel: AdvertisementDescriptionViewModelProtocol)
}

final class AdvertisementsViewModel: AdvertisementsViewModelProtocol {
    
    weak var delegate: AdvertisementsViewModelDelegate?
    private var advertisements: [Advertisement]?
    private let advertisementService: AdvertisementService
    
    init(advertisementService: AdvertisementService) {
        self.advertisementService = advertisementService
    }
    
    var advertisementsCount: Int {
        return advertisements?.count ?? 0
    }
    
    func didTapFilter() {
        delegate?.didTapFilter(viewModel: self)
    }
    
    func didTapAdvertisement(index: Int) {
        guard advertisements?.isValidIndex(index) ?? false else { return }
        let descriptionViewModel = getAdvertisementDescriptionViewModel(index: index)
        delegate?.didTapAdvertisement(viewModel: descriptionViewModel)
    }
    
    func refreshAdvertisementList(completionHandler: @escaping ()->()) {
        CategoryService.sharedInstance.getCategories { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                strongSelf.advertisementService.getAdvertisements { [weak self] (result) in
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let advertisements):
                        strongSelf.advertisements = advertisements ?? []
                    default: break
                    }
                
                    completionHandler()
                }
            default: completionHandler()
            }
        }
    }
    
}

extension AdvertisementsViewModel {
    
    func getIsNotUrgent(index: Int) -> Bool {
        return !(getAdvertisement(index: index)?.isUrgent ?? true)
    }
    
    func getPrice(index: Int) -> String {
        return getAdvertisement(index: index)?.price.formattedPrice ?? ""
    }
    
    func getTitle(index: Int) -> String {
        return getAdvertisement(index: index)?.title ?? ""
    }
    
    func getCategory(index: Int) -> String {
        return getAdvertisement(index: index)?.categoryName ?? ""
    }
}

private extension AdvertisementsViewModel {
    
    func getAdvertisement(index: Int) -> Advertisement? {
        guard advertisements?.isValidIndex(index) ?? false, let advertisement = advertisements?[index] else { return nil }
        return advertisement
    }
    
    func getAdvertisementDescriptionViewModel(index: Int) -> AdvertisementDescriptionViewModelProtocol {
        return AdvertisementDescriptionViewModel()
    }
}
