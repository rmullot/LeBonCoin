//
//  CoreDataService+Advertisement.swift
//  LBCCoreData
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCAPI
import LBCCore
import CoreData

public protocol AdvertisementsCoreDataServiceProtocol: AnyObject {
    func saveAdvertisements(_ advertisements: [AdvertisementJSON])
}


extension CoreDataService: AdvertisementsCoreDataServiceProtocol  {
    
    public func saveAdvertisements(_ advertisements: [AdvertisementJSON]) {
        var errorMessage = ""
        
        advertisements.forEach {
            convertToAdvertisementCoreData($0, completionHandler: { result in
                switch result {
                case .failure(let message):
                    errorMessage = message.localizedDescription
                default:
                    break
                }
            })
        }
        
        guard errorMessage.isEmpty else {
            print(errorMessage)
            return
        }
        saveContext()
    }
}

// MARK: - Private methods
private extension CoreDataService {
    
    func convertToAdvertisementCoreData(_ advertisement: AdvertisementJSON, completionHandler: CoreDataCallback<AdvertisementCoreData>? = nil) {
        
        //check if object exists already or create new one
        
        let predicate = NSPredicate(format: "%@ == %@", argumentArray: [ \AdvertisementCoreData.idAdvertisement, advertisement.idAdvertisement])
        
        get(value: AdvertisementCoreData.self, isMaincontext: false, predicate: predicate, sortParameters: nil) { (result) in
            switch result {
            case .success(let objectsCoreData):
                // more than 1 object with same id problem ?
                guard let objectsCoreData = objectsCoreData, objectsCoreData.count <= 1 else {
                    completionHandler?(.failure(.duplicateObject("already in the coredata cache")))
                    return
                }
                // check object already in cache
                guard let resultObject: AdvertisementCoreData = objectsCoreData.count == 1 ? objectsCoreData[0] : NSEntityDescription.insertNewObject(forEntityName: String(describing: AdvertisementCoreData.self), into: backgroundManagedObjectContext) as? AdvertisementCoreData else {
                    completionHandler?(.failure(.genericError("Error: Cannot create AdvertisementCoreData")))
                    return
                }
                
                resultObject.title = advertisement.title
                resultObject.creationDate = advertisement.creationDate
                resultObject.descriptionAdvert = advertisement.description
                resultObject.idAdvertisement = Int64(advertisement.idAdvertisement)
                resultObject.isUrgent = advertisement.isUrgent
                resultObject.price = advertisement.price
                if let categoryCoreData = getCategory(idCategory: advertisement.idCategory) {
                    resultObject.category = categoryCoreData
                }
                
                var imagesCoreData: Set<ImageCoreData> = Set<ImageCoreData>()
                if let imagesUrl = advertisement.imageUrls {
                    if let imageThumb = imagesUrl.thumb, let imageResultObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: ImageCoreData.self), into: backgroundManagedObjectContext) as? ImageCoreData {
                        imageResultObject.type = "thumb"
                        imageResultObject.url = imageThumb
                        imagesCoreData.insert(imageResultObject)
                    }
                    
                    if let imageSmall = imagesUrl.small, let imageResultObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: ImageCoreData.self), into: backgroundManagedObjectContext) as? ImageCoreData {
                        
                        imageResultObject.type = "small"
                        imageResultObject.url = imageSmall
                        imagesCoreData.insert(imageResultObject)
                    }
                    
                }
                resultObject.images = imagesCoreData
                completionHandler?(.success([resultObject]))
            case .failure(let error):
                completionHandler?(.failure(.genericError("Error fetch object : \(error)")))
            }
        }
    }
    
}
