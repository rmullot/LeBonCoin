//
//  CoreDataService+Category.swift
//  LBCCoreData
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCAPI
import CoreData

public protocol CategoriesCoreDataServiceProtocol: AnyObject {
    func saveCategories(_ categories: [CategoryJSON])
    func getCategory(idCategory: Int) -> CategoryCoreData?
}

extension CoreDataService: CategoriesCoreDataServiceProtocol  {
    
    public func saveCategories(_ categories: [CategoryJSON]) {
        var errorMessage = ""
        
        categories.forEach {
            convertToCategoryCoreData($0, completionHandler: { result in
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
    
    public func getCategory(idCategory: Int) -> CategoryCoreData? {
        
        let predicate = NSPredicate(format: "%@ == %@", argumentArray: [ \CategoryCoreData.idCategory, idCategory])
        return get(value: CategoryCoreData.self, isMaincontext: false, predicate: predicate, sortParameters: nil)
    }
}

// MARK: - Private methods

private extension CoreDataService {
    func convertToCategoryCoreData(_ category: CategoryJSON, completionHandler: CoreDataCallback<CategoryCoreData>? = nil) {
        
        //check if object exists already or create new one
        
        let predicate = NSPredicate(format: "%@ == %@", argumentArray: [ \CategoryCoreData.idCategory, category.idCategory])
        
        get(value: CategoryCoreData.self, isMaincontext: false, predicate: predicate, sortParameters: nil) { (result) in
            switch result {
            case .success(let objectsCoreData):
                // more than 1 object with same id problem ?
                guard let objectsCoreData = objectsCoreData, objectsCoreData.count <= 1 else {
                    completionHandler?(.failure(.duplicateObject("already in the coredata cache")))
                    return
                }
                // check object already in cache
                guard let resultObject: CategoryCoreData = objectsCoreData.count == 1 ? objectsCoreData[0] : NSEntityDescription.insertNewObject(forEntityName: String(describing: CategoryCoreData.self), into: backgroundManagedObjectContext) as? CategoryCoreData else {
                    completionHandler?(.failure(.genericError("Error: Cannot create NSManagedObject")))
                    return
                }
                resultObject.idCategory = Int16(category.idCategory)
                resultObject.name = category.name
                completionHandler?(.success([resultObject]))
            case .failure(let error):
                completionHandler?(.failure(.genericError("Error fetch object : \(error)")))
            }
        }
    }
}
