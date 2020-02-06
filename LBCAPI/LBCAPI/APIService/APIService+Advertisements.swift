//
//  APIService+Advertisements.swift
//  LBCAPI
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public protocol APIAdvertisementsProtocol: AnyObject {
    func getAdvertisements(completionHandler: @escaping (Result<[AdvertisementJSON], Swift.Error>) -> Void)
}

public extension APIService {
    
    private enum LBCKeys: String {
        case urlAdvertisements = "listing.json"
    }
    
    func getAdvertisements(completionHandler: @escaping (Result<[AdvertisementJSON], Swift.Error>) -> Void) {
        let url = "\(uri)\(LBCKeys.urlAdvertisements.rawValue)"
        getDataWith(urlString: url, type: .advertisements, completion: { (result) in
            switch result {
            case .success(let data):
                ParserService<[AdvertisementJSON]>.parse(data, completionHandler: { (result) in
                    switch result {
                    case .success(let advertisements):
                        guard let advertisements = advertisements  else {
                            completionHandler(.failure(WebServiceErrorMessage.badObjectType))
                            return
                        }
                        completionHandler(.success(advertisements))
                    case .failure(_, let message):
                        completionHandler(.failure(WebServiceErrorMessage.customMessage(message)))
                    }
                })
                
            case .failure(let message):
                completionHandler(.failure(message))
            }
        })
    }
}
