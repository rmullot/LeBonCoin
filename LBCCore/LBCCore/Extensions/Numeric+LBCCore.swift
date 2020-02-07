//
//  Numeric+LBCCore.swift
//  LBCCore
//
//  Created by Romain Mullot on 03/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public extension Numeric {
    var formattedPrice: String {
        return FormatterService.sharedInstance.numberFormatterWith(key: .price).string(for: self) ?? ""
    }
}
