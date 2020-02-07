//
//  AdvertisementDescriptionViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCBridge

protocol AdvertisementDescriptionViewModelProtocol: AnyObject {
    var delegate: AdvertisementDescriptionViewModelDelegate? { get set }
    var title: String { get }
    var descriptionAdvertisement: String { get }
    var creationDate: String { get }
    var isNotUrgent: Bool { get }
    var price: String { get }
    var category: String { get }
    var smallPhotoUrl: String { get }
    func didTapBack()
}

protocol AdvertisementDescriptionViewModelDelegate: AnyObject {
    func didTapBack()
}

final class AdvertisementDescriptionViewModel: AdvertisementDescriptionViewModelProtocol {
    weak var delegate: AdvertisementDescriptionViewModelDelegate?
    let advertisement: Advertisement
    
    var title: String {
        return advertisement.title
    }
    
    var descriptionAdvertisement: String {
        return advertisement.descriptionAdvert
    }
    
    var creationDate: String {
        return advertisement.creationDate.descriptionDateString
    }
    
    var isNotUrgent: Bool {
        return !advertisement.isUrgent
    }
    
    var price: String {
        return advertisement.price.formattedPrice
    }
    
    var category: String {
        return advertisement.categoryName
    }
    
    var smallPhotoUrl: String {
        return advertisement.imageUrls[AdvertisementImageSize.small.rawValue] ?? ""
    }
    
    init(advertisement: Advertisement) {
        self.advertisement = advertisement
    }
    
    func didTapBack() {
        if let url = URL(string: smallPhotoUrl) {
            URLSession.shared.getAllTasks { tasks in
                 tasks
                   .filter { $0.state == .running }
                   .filter { $0.originalRequest?.url == url }.first?
                   .cancel()
               }
        }
        delegate?.didTapBack()
    }
}
