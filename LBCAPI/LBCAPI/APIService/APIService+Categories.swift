//
//  APIService+Categories.swift
//  LBCAPI
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public protocol APICategoriesProtocol: AnyObject {
    func getCategories(completionHandler: @escaping (Result<[CategoryJSON], Error>) -> Void)
}

public extension APIService {
    
    private enum LBCKeys: String {
        case urlCategories = "categories.json"
    }
    
    func getCategories(completionHandler: @escaping (Result<[CategoryJSON], Error>) -> Void) {
          
          let url = "\(uri)\(LBCKeys.urlCategories.rawValue)"
          getDataWith(urlString: url, type: .categories, completion: { (result) in
              switch result {
              case .success(let data):
                  ParserService<[CategoryJSON]>.parse(data, completionHandler: { (result) in
                      switch result {
                      case .success(let categories):
                        guard let categories = categories  else {
                            completionHandler(.failure(WebServiceErrorMessage.badObjectType))
                            return
                        }
                          completionHandler(.success(categories))
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
