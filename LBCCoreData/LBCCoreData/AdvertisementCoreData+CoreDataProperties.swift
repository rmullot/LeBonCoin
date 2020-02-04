//
//  AdvertisementCoreData+CoreDataProperties.swift
//  
//
//  Created by Romain Mullot on 04/02/2020.
//
//

import Foundation
import CoreData


extension AdvertisementCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdvertisementCoreData> {
        return NSFetchRequest<AdvertisementCoreData>(entityName: "AdvertisementCoreData")
    }

    @NSManaged public var idAdvertisement: Int64
    @NSManaged public var title: String?
    @NSManaged public var descriptionAdvert: String?
    @NSManaged public var price: Float
    @NSManaged public var creationDate: Date?
    @NSManaged public var isUrgent: Bool
    @NSManaged public var category: CategoryCoreData?
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for images
extension AdvertisementCoreData {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageCoreData)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageCoreData)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
