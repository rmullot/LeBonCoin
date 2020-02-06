//
//  UIImageView+Cache.swift
//  LBCUIKit
//
//  Created by Romain Mullot on 06/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

import UIKit
import LBCCore
import LBCNetwork

private let imageCache = NSCache<NSString, UIImage>()
private var urlCache = [String:String]()

public enum ImageResult {
    case success(UIImage, String)
    case failure(String)
}

public typealias ImageCallback = (ImageResult) -> Void

extension UIImageView {
    
    public func loadImage(urlString: String, placeHolder: UIImage?,completionHandler: ImageCallback? = nil) {
        
        let imageToDecode: (UIImage?) -> UIImage? = { image in
            guard let image = image else { return nil }
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            image.draw(at: CGPoint.zero)
            let decodedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return decodedImage
        }
        
        image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = imageToDecode(cachedImage)
            completionHandler?(.success(cachedImage, urlString))
            return
        }
        
        urlString.isUrl({ (success, url) in
            if  let url = url, urlCache[urlString] == nil, success {
                urlCache[urlString] = urlString
                NetworkActivityService.sharedInstance.newRequestStarted()
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    defer {
                        DispatchQueue.main.async {
                            NetworkActivityService.sharedInstance.requestFinished()
                        }
                    }
                    
                    if let errorTmp = error {
                        let errorString = "ERROR LOADING IMAGES FROM URL: \(errorTmp.localizedDescription)"
                        if let decodedPlaceHolder = imageToDecode(placeHolder) {
                            DispatchQueue.main.async { [weak self] in
                                guard let strongSelf = self else {
                                    completionHandler?(.failure(errorString))
                                    return
                                }
                                strongSelf.image = decodedPlaceHolder
                                completionHandler?(.failure(errorString))
                            }
                        }
                        return
                    }
                    if let data = data, let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                        if let decodedDownloadedImage = imageToDecode(downloadedImage) {
                            urlCache.removeValue(forKey:urlString)
                            DispatchQueue.main.async { [weak self] in
                                guard let strongSelf = self else {
                                    completionHandler?(.failure("UIImageView deallocated"))
                                    return
                                }
                                strongSelf.image = decodedDownloadedImage
                                completionHandler?(.success(downloadedImage, urlString))
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completionHandler?(.failure("Image Data invalid"))
                        }
                    }
                }).resume()
            }
        })
    }
}
