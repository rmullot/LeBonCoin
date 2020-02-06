//
//  FormatterService.swift
//  LBCCore
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public extension String {
    
    /// Return a boolean checking if the string is not empty
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    /// Return a converted iso8601 Date
    var iso8601Date: Date {
        guard isNotEmpty else { return Date() }
        guard let date = FormatterService.sharedInstance.dateFormatterWith(key: .iso8601Date).date(from: self) else { return Date() }
        return date
    }

}
