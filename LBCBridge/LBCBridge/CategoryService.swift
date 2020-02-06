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
    func getCategories(completionHandler: @escaping (Result<[Category]?, Error>) -> Void)
}

public final class CategoryService: CategoryServiceProtocol {
    
    private init() {}
    
    public static let sharedInstance = CategoryService()
    
    public func getCategories(completionHandler: @escaping (Result<[Category]?, Error>) -> Void) {
        let sortParameters = [["name": true]]
        
        if APIService.sharedInstance.onlineMode != .offline {
            callWebservice(completionHandler: { [weak self] (result) -> Void in
                guard let strongSelf = self else {
                    completionHandler(.failure(WebServiceErrorMessage.unknownError))
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
    
    func getCategoriesFromCoreData(sortParameters: [[String: Bool]], completionHandler: (Result<[Category]?, Error>) -> Void) {
        CoreDataService.sharedInstance.get(value: CategoryCoreData.self, isMaincontext: true, predicate: nil, sortParameters: sortParameters) { (result) in
            switch result {
            case .success(let results):
                let categories = results?.map( { Category(category: $0) })
                completionHandler(.success(categories))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func callWebservice(completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        APIService.sharedInstance.getCategories(completionHandler: { (result) in
            switch result {
            case .success(let resources):
                CoreDataService.sharedInstance.clearData(CategoryCoreData.self)
                CoreDataService.sharedInstance.saveCategories(resources)
                completionHandler(.success(true))
            case .failure(let message):
                print(message)
                completionHandler(.failure(message))
            }
        })
    }
}
