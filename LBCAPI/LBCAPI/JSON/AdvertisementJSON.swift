//
//  AdvertisementJSON.swift
//  LBCAPI
//
//  Created by Romain Mullot on 02/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public struct AdvertisementJSON: Codable {
    public var idAdvertisement: Int = 0
    public var idCategory: Int = 0
    public var title: String = ""
    public var description: String = ""
    public var price: Float = 0
    public var creationDate: Date = Date()
    public var imageUrls: ImagesJSON?
    public var isUrgent: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case idAdvertisement = "id"
        case idCategory = "category_id"
        case title = "title"
        case description = "description"
        case price = "price"
        case creationDate = "creation_date"
        case imageUrls = "images_url"
        case isUrgent = "is_urgent"
        
    }
    
    public init(idAdvertisement: Int = 0, idCategory: Int = 0, title: String = "", description: String = "", price: Float = 0, creationDate: Date = Date(), imageUrls: ImagesJSON?, isUrgent: Bool = false) {
        self.idAdvertisement = idAdvertisement
        self.idCategory = idCategory
        self.title = title
        self.description = description
        self.price = price
        self.creationDate = creationDate
        self.imageUrls = imageUrls
        self.isUrgent = isUrgent
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idAdvertisement = try values.decode(Int.self, forKey: .idAdvertisement)
        idCategory = try values.decode(Int.self, forKey: .idCategory)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        price = try values.decode(Float.self, forKey: .price)
        let creationDateString = try values.decode(String.self, forKey: .creationDate)
        //TODO: To create a cache for date
        creationDate = Date()
        imageUrls = try values.decodeIfPresent(ImagesJSON.self, forKey: .imageUrls)
        isUrgent = try values.decode(Bool.self, forKey: .isUrgent)
    }
    
}
