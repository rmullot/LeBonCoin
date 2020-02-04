//
//  Advertisement.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCCoreData

final class Advertisement {
    
    let idAdvertisement: Int
    let idCategory: Int
    let title: String
    let description: String
    let price: Float
    let creationDate: Date
    let imageUrls: [String: String]
    let isUrgent: Bool
    
    
    init(idAdvertisement: Int = 0, idCategory: Int = 0, title: String = "", description: String = "", price: Float = 0, creationDate: Date = Date(), imageUrls: [String: String], isUrgent: Bool = false) {
        self.idAdvertisement = idAdvertisement
        self.idCategory = idCategory
        self.title = title
        self.description = description
        self.price = price
        self.creationDate = creationDate
        self.imageUrls = imageUrls
        self.isUrgent = isUrgent
    }
    
    init(advertisement: AdvertisementCoreData) {
        idAdvertisement = Int(advertisement.idAdvertisement)
        idCategory = Int(advertisement.category.idCategory)
        title = advertisement.title
        description = advertisement.description
        price = advertisement.price
        creationDate = advertisement.creationDate
        if let images = advertisement.images {
            var imageTmpUrls: [String: String] = [:]
            images.forEach { (imageCoreData) in
                imageTmpUrls[imageCoreData.type] = imageCoreData.url
            }
            imageUrls = imageTmpUrls
        } else {
            imageUrls = [:]
        }
        isUrgent = advertisement.isUrgent
    }
    
}
