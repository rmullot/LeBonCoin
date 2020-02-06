//
//  AdvertisementService.swift
//  LBCBridge
//
//  Created by Romain Mullot on 06/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

import LBCCoreData
import LBCAPI

public protocol AdvertisementServiceProtocol {
  func getAdvertisements(idCategories: [Int], completionHandler: @escaping (Result<[Advertisement]?>) -> Void)
}

public final class AdvertisementService: AdvertisementServiceProtocol {

  private init() {}

  public static let sharedInstance = AdvertisementService()

    public func getAdvertisements(idCategories: [Int] = [], completionHandler: @escaping (Result<[Advertisement]?>) -> Void) {
        let sortParameters = [["isUrgent": true], ["creationDate": false]]
        let filterPredicate = NSPredicate(format: "%K IN %@", argumentArray: [\AdvertisementCoreData.category.idCategory, idCategories])

      if APIService.sharedInstance.onlineMode != .offline {
        callWebservice(completionHandler: { [weak self] (success, errorMessage) -> Void in
          guard let strongSelf = self, success else {
            completionHandler(.error("\(errorMessage)"))
            return
          }
            // catch and convert
            strongSelf.getAdvertisementsFromCoreData(filterPredicate: filterPredicate, sortParameters: sortParameters, completionHandler: completionHandler)
        })
      } else {
       // catch and convert
        getAdvertisementsFromCoreData(filterPredicate: filterPredicate, sortParameters: sortParameters, completionHandler: completionHandler)
      }
  }

}

private extension AdvertisementService {
    
    func getAdvertisementsFromCoreData(filterPredicate: NSPredicate, sortParameters: [[String: Bool]], completionHandler: @escaping (Result<[Advertisement]?>) -> Void) {
        CoreDataService.sharedInstance.get(value: AdvertisementCoreData.self, isMaincontext: true, predicate: filterPredicate, sortParameters: sortParameters) { (result) in
            switch result {
            case .success(let results):
                let advertisements = results?.map( { Advertisement(advertisement: $0) })
                completionHandler(.success(advertisements))
            case .failure(let error):
                completionHandler(.error("\(error)"))
            }
        }
    }
    
    func callWebservice(completionHandler: @escaping (_ success: Bool, _ errorMessage: String) -> Void) {
        APIService.sharedInstance.getCategories(completionHandler: { (result) in
            switch result {
            case .success(let resources):
                CoreDataService.sharedInstance.clearData(CategoryCoreData.self)
                CoreDataService.sharedInstance.saveCategories(resources)
                completionHandler(true, "")
            case .error(let message):
                print(message)
                completionHandler(false, message)
            }
        })
    }
}
