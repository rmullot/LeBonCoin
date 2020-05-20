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
import LBCNetwork

protocol AdvertisementsViewModelProtocol: AnyObject {
    var advertisementsCount: Int { get }
    func getIsNotUrgent(index: Int) -> Bool
    func getPrice(index: Int) -> String
    func getTitle(index: Int) -> String
    func getCategory(index: Int) -> String
    func getThumbImage(index: Int) -> String
    func didTapFilter()
    func didTapAdvertisement(index: Int)
    func refreshAdvertisementList(completionHandler: @escaping ()->())
    func getAdvertisementList(completionHandler: @escaping ()->())
    init(advertisementService: AdvertisementServiceProtocol, categoryService: CategoryServiceProtocol)
    var delegate: AdvertisementsViewModelDelegate? { get set }
}

protocol AdvertisementsViewModelDelegate: AnyObject {
    func didTapFilter(viewModel: AdvertisementsViewModelProtocol)
    func didTapAdvertisement(advertisement: Advertisement)
}

final class AdvertisementsViewModel: AdvertisementsViewModelProtocol {
    
    weak var delegate: AdvertisementsViewModelDelegate?
    private var advertisements: [Advertisement]?
    private let advertisementService: AdvertisementServiceProtocol
    private let categoryService: CategoryServiceProtocol
    
    init(advertisementService: AdvertisementServiceProtocol, categoryService: CategoryServiceProtocol) {
        self.advertisementService = advertisementService
        self.categoryService = categoryService
    }
    
    var advertisementsCount: Int {
        return advertisements?.count ?? 0
    }
    
    func didTapFilter() {
        delegate?.didTapFilter(viewModel: self)
    }
    
    func didTapAdvertisement(index: Int) {
        guard let advertisement = getAdvertisement(index: index) else { return }
        delegate?.didTapAdvertisement(advertisement: advertisement)
    }
    
    func refreshAdvertisementList(completionHandler: @escaping ()->()) {
        categoryService.refreshCategories { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(_):
                strongSelf.advertisementService.refreshAdvertisements { [weak self] (result) in
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
    
    func getAdvertisementList(completionHandler: @escaping ()->()) {
        advertisementService.getAdvertisementsWithFilter { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let advertisements):
                strongSelf.advertisements = advertisements ?? []
            default: break
            }
            completionHandler()
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
    
    func getThumbImage(index: Int) -> String {
        return getAdvertisement(index: index)?.imageUrls[AdvertisementImageSize.thumb.rawValue] ?? ""
    }
}

private extension AdvertisementsViewModel {
    
    func getAdvertisement(index: Int) -> Advertisement? {
        guard advertisements?.isValidIndex(index) ?? false, let advertisement = advertisements?[index] else { return nil }
        return advertisement
    }
}
