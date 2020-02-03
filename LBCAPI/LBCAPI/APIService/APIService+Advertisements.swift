//
//  APIService+Advertisements.swift
//  LBCAPI
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public protocol APIAdvertisementsProtocol: AnyObject {
    func getAdvertisements(completionHandler: @escaping (Result<[AdvertisementJSON]>) -> Void)
}

public extension APIService {
    
    private enum LBCKeys: String {
        case urlAdvertisements = "listing.json"
    }
    
    func getAdvertisements(completionHandler: @escaping (Result<[AdvertisementJSON]>) -> Void) {
        let url = "\(uri)\(LBCKeys.urlAdvertisements.rawValue)"
        getDataWith(urlString: url, type: .advertisements, completion: { (result) in
            switch result {
            case .success(let data):
                ParserService<[AdvertisementJSON]>.parse(data, completionHandler: { (result) in
                    switch result {
                    case .success(let advertisements):
                        guard let advertisements = advertisements  else {
                            completionHandler(.error(String(format: WebServiceErrorMessage.badObjectType.rawValue, String(describing: [AdvertisementJSON].self))))
                            return
                        }
                        completionHandler(.success(advertisements))
                    case .failure(_, let message):
                        completionHandler(.error(message))
                    }
                })
                
            case .error(let message):
                completionHandler(.error(message))
            }
        })
    }
}
