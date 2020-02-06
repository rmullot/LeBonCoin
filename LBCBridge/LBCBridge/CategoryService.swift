//
//  CategoryService.swift
//  LBCBridge
//
//  Created by Romain Mullot on 06/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

import LBCCoreData
import LBCAPI

public protocol CategoryServiceProtocol {
  func getCategories(completionHandler: @escaping (Result<[Category]?>) -> Void)
}

public final class CategoryService: CategoryServiceProtocol {

  private init() {}

  public static let sharedInstance = CategoryService()

    public func getCategories(completionHandler: @escaping (Result<[Category]?>) -> Void) {
        let sortParameters = [["name": true]]

      if APIService.sharedInstance.onlineMode != .offline {
        callWebservice(completionHandler: { [weak self] (success, errorMessage) -> Void in
          guard let strongSelf = self, success else {
            completionHandler(.error("\(errorMessage)"))
            return
          }
            // catch and convert
            strongSelf.getCategoriesFromCoreData(sortParameters: sortParameters, completionHandler: completionHandler)
        })
      } else {
       // catch and convert
        getCategoriesFromCoreData(sortParameters: sortParameters, completionHandler: completionHandler)
      }
  }

}

private extension CategoryService {
    
    func getCategoriesFromCoreData(sortParameters: [[String: Bool]], completionHandler: @escaping (Result<[Category]?>) -> Void) {
        CoreDataService.sharedInstance.get(value: CategoryCoreData.self, isMaincontext: true, predicate: nil, sortParameters: sortParameters) { (result) in
            switch result {
            case .success(let results):
                let categories = results?.map( { Category(category: $0) })
                completionHandler(.success(categories))
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
