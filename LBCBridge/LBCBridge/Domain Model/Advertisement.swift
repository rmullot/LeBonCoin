//
//  Advertisement.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCCoreData

public enum AdvertisementImageSize: String {
    case thumb
    case small
}

final public class Advertisement {
    
    public let idAdvertisement: Int
    public let categoryName: String
    public let idCategory: Int
    public let title: String
    public let descriptionAdvert: String
    public let price: Float
    public let creationDate: Date
    public let imageUrls: [String: String]
    public let isUrgent: Bool
    
    
    init(idAdvertisement: Int = 0, categoryName: String = "", idCategory: Int = 0, title: String = "", description: String = "", price: Float = 0, creationDate: Date = Date(), imageUrls: [String: String], isUrgent: Bool = false) {
        self.idAdvertisement = idAdvertisement
        self.categoryName = categoryName
        self.idCategory = idCategory
        self.title = title
        self.descriptionAdvert = description
        self.price = price
        self.creationDate = creationDate
        self.imageUrls = imageUrls
        self.isUrgent = isUrgent
    }
    
    init(advertisement: AdvertisementCoreData) {
        idAdvertisement = Int(advertisement.idAdvertisement)
        idCategory = Int(advertisement.category.idCategory)
        categoryName = advertisement.category.name
        title = advertisement.title
        descriptionAdvert = advertisement.descriptionAdvert
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
