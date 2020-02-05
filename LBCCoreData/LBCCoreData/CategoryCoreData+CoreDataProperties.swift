//
//  CategoryCoreData+CoreDataProperties.swift
//  
//
//  Created by Romain Mullot on 04/02/2020.
//
//

import Foundation
import CoreData


extension CategoryCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCoreData> {
        return NSFetchRequest<CategoryCoreData>(entityName: "CategoryCoreData")
    }

    @NSManaged public var idCategory: Int16
    @NSManaged public var name: String
    @NSManaged public var advertisements: Set<AdvertisementCoreData>?

}

// MARK: Generated accessors for advertisements
extension CategoryCoreData {

    @objc(addAdvertisementsObject:)
    @NSManaged public func addToAdvertisements(_ value: AdvertisementCoreData)

    @objc(removeAdvertisementsObject:)
    @NSManaged public func removeFromAdvertisements(_ value: AdvertisementCoreData)

    @objc(addAdvertisements:)
    @NSManaged public func addToAdvertisements(_ values: NSSet)

    @objc(removeAdvertisements:)
    @NSManaged public func removeFromAdvertisements(_ values: NSSet)

}
