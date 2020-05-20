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
import CoreData

public protocol AdvertisementServiceProtocol: AnyObject {
    func getAdvertisementsWithFilter(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void)
    func refreshAdvertisements(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void)
}

public final class AdvertisementService: AdvertisementServiceProtocol {
    
    private init() {}
    
    public static let sharedInstance = AdvertisementService()
    
    private var predicateSelectCategories: NSPredicate? {
        guard CategoryService.sharedInstance.selectedCategories.isNotEmpty else { return nil }
        return NSPredicate(format: "%K IN %@", #keyPath(AdvertisementCoreData.category.idCategory), CategoryService.sharedInstance.selectedCategories)
    }
    
    public func getAdvertisementsWithFilter(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void) {
        let sortParameters = [["isUrgent": false], ["creationDate": false]]
        var filterPredicate: NSPredicate? = nil
        if CategoryService.sharedInstance.selectedCategories.isNotEmpty {
            filterPredicate = NSPredicate(format: "%K IN %@", argumentArray: [#keyPath(AdvertisementCoreData.category.idCategory), CategoryService.sharedInstance.selectedCategories])
        }
        // catch and convert
        getAdvertisementsFromCoreData(filterPredicate: filterPredicate, sortParameters: sortParameters, completionHandler: completionHandler)
    }
    
    public func refreshAdvertisements(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void) {
        let sortParameters = [["isUrgent": false], ["creationDate": false]]
        if APIService.sharedInstance.onlineMode != .offline {
            callWebservice(completionHandler: { [weak self] (result) -> Void in
                guard let strongSelf = self else {
                    completionHandler(.failure(WebServiceErrorMessage.unknownError))
                    return
                }
                // catch and convert
                strongSelf.getAdvertisementsFromCoreData(filterPredicate: nil, sortParameters: sortParameters, completionHandler: completionHandler)
            })
        } else {
            // catch and convert
            getAdvertisementsFromCoreData(filterPredicate: nil, sortParameters: sortParameters, completionHandler: completionHandler)
        }
    }
    
}

private extension AdvertisementService {
    
    func getAdvertisementsFromCoreData(filterPredicate: NSPredicate?, sortParameters: [[String: Bool]], completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void) {
        CoreDataService.sharedInstance.get(value: AdvertisementCoreData.self, isMaincontext: true, predicate: filterPredicate, sortParameters: sortParameters) { (result) in
            switch result {
            case .success(let results):
                let advertisements = results?.map( { Advertisement(advertisement: $0) })
                completionHandler(.success(advertisements))
            case .failure(let messageError):
                completionHandler(.failure(messageError))
            }
        }
    }
    
    func callWebservice(completionHandler: @escaping (Result<Bool,Error>) -> Void) {
        APIService.sharedInstance.getAdvertisements(completionHandler: { (result) in
            switch result {
            case .success(let resources):
                CoreDataService.sharedInstance.clearData(AdvertisementCoreData.self)
                CoreDataService.sharedInstance.saveAdvertisements(resources)
                completionHandler(.success(true))
            case .failure(let message):
                print(message)
                completionHandler(.failure(message))
            }
        })
    }
}
