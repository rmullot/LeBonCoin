//
//  FormatterService.swift
//  LBCCore
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol FormatterServiceProtocol {
    func rebootCache()
    func dateFormatterWith(key: FormatterKey) -> DateFormatter
    func numberFormatterWith(key: FormatterKey) -> NumberFormatter
}

public enum FormatterKey: String {
    case iso8601Date
    case price
}

public final class FormatterService: FormatterServiceProtocol {
    
    public static let sharedInstance = FormatterService()
    
    // MARK: Properties
    
    private var cachedFormatters = [String: Formatter]()
    
    // MARK: Initialization
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(FormatterService.rebootCache), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Cache
    @objc
    public func rebootCache() {
        cachedFormatters.removeAll()
    }
    
    // MARK: Getting formatters
    
    public func dateFormatterWith(key: FormatterKey) -> DateFormatter {
        
        if let cachedDateFormatter = cachedFormatters[key.rawValue] as? DateFormatter {
            return cachedDateFormatter
        } else {
            guard let newDateFormatter = getFormatter(key: key) as? DateFormatter else {
                return DateFormatter()
            }
            cachedFormatters[key.rawValue] = newDateFormatter
            return newDateFormatter
        }
    }
    
    public func numberFormatterWith(key: FormatterKey) -> NumberFormatter {
        
        if let cachedDateFormatter = cachedFormatters[key.rawValue] as? NumberFormatter {
            return cachedDateFormatter
        } else {
            guard let newDateFormatter = getFormatter(key: key) as? NumberFormatter else {
                return NumberFormatter()
            }
            cachedFormatters[key.rawValue] = newDateFormatter
            return newDateFormatter
        }
    }
  
}

private extension FormatterService {
    
    func getFormatter(key: FormatterKey) -> Formatter {
        switch key {
        case .iso8601Date:
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return formatter
        case .price:
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "EUR"
            formatter.currencySymbol = "€"
            return formatter
        }
    }
}
