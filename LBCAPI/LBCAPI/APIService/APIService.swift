//
//  WebService.swift
//  LBCAPI
//
//  Created by Romain Mullot on 02/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import LBCNetwork

public protocol APIServiceProtocol: APIAdvertisementsProtocol, APICategoriesProtocol {
    func cancelRequests()
}

public enum WebServiceErrorMessage: Swift.Error {
       case noNetwork
       case invalidURL
       case unknownError
       case badObjectType
       case customMessage(String?)
   }

public final class APIService: APIServiceProtocol {
    
    // MARK: Attributes
    
    internal enum TypeWebService {
        case advertisements
        case categories
    }
    
    internal let uri = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    
    public var onlineMode: OnlineMode = .online
    
    public static let sharedInstance = APIService()
    
    // MARK: - Public Methods
    
    public func cancelRequests() {
        URLSession.shared.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
            for task in dataTask {
                task.cancel()
            }
            for task in uploadTask {
                task.cancel()
            }
            for task in downloadTask {
                task.cancel()
            }
            NetworkActivityService.sharedInstance.disableActivityIndicator()
        }
    }
    
    private init() {
        ReachabilityService.sharedInstance.delegates.add(self)
    }
    
    deinit {
        ReachabilityService.sharedInstance.delegates.remove(self)
    }
    
}

// MARK: - Private Methods

internal extension APIService {
    
    func getDataWith(urlString: String, type: TypeWebService, completion: @escaping (Result<Data, WebServiceErrorMessage>) -> Void) {
        guard onlineMode != .offline else { return completion(.failure(WebServiceErrorMessage.noNetwork)) }
        guard let url = URL(string: urlString) else { return completion(.failure(WebServiceErrorMessage.invalidURL)) }
        var request = URLRequest(url: url)
        switch type {
        case .advertisements, .categories:
            request.httpMethod = "GET"
        }
        
        NetworkActivityService.sharedInstance.newRequestStarted()
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                NetworkActivityService.sharedInstance.requestFinished()
                guard error == nil else { return completion(.failure(.customMessage(error?.localizedDescription))) }
                guard let data = data else { return completion(.failure(.unknownError)) }
                return completion(.success(data))
            }
        }.resume()
    }
}

// MARK: - ReachabilityManagerDelegate
extension APIService: ReachabilityServiceDelegate {
    
    public func onlineModeChanged(_ newMode: OnlineMode) {
        if onlineMode != newMode {
            onlineMode = newMode
        }
    }
}
