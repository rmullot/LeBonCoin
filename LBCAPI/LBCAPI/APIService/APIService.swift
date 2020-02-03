//
//  WebService.swift
//  LBCAPI
//
//  Created by Romain Mullot on 02/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import LBCNetwork

public enum Result<T> {
    case success(T)
    case error(String)
}

public protocol APIServiceProtocol: APIAdvertisementsProtocol, APICategoriesProtocol {
    func cancelRequests()
}

public final class APIService: APIServiceProtocol {
    
    // MARK: Attributes
    
    internal enum TypeWebService {
        case advertisements
        case categories
    }
    
    internal enum WebServiceErrorMessage: String {
        case noNetwork = "No network available"
        case invalidURL = "Invalid URL, we can't update your feed"
        case unknownError = "Error from network not identified"
        case badObjectType = "Returned object is not %@ type"
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
    
    func getDataWith(urlString: String, type: TypeWebService, completion: @escaping (Result<Data>) -> Void) {
        guard onlineMode != .offline else { return completion(.error(WebServiceErrorMessage.noNetwork.rawValue)) }
        guard let url = URL(string: urlString) else { return completion(.error(WebServiceErrorMessage.invalidURL.rawValue)) }
        var request = URLRequest(url: url)
        switch type {
        case .advertisements, .categories:
            request.httpMethod = "GET"
        }
        
        NetworkActivityService.sharedInstance.newRequestStarted()
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                NetworkActivityService.sharedInstance.requestFinished()
                guard error == nil else { return completion(.error(error!.localizedDescription)) }
                guard let data = data else { return completion(.error(error?.localizedDescription ?? WebServiceErrorMessage.unknownError.rawValue)) }
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
