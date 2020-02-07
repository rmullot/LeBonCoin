//
//  Collection+LBCCore.swift
//  LBCCore
//
//  Created by Romain Mullot on 06/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

extension Collection {

  /// Return a boolean checking if the array is not empty
  public var isNotEmpty: Bool {
    return !isEmpty
  }

  public func isValidIndex(_ index: Int) -> Bool {
    guard isNotEmpty else { return false }
    return  index < count && index >= 0
  }

}
