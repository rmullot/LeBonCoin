//
//  ImagesJSON.swift
//  LBCAPI
//
//  Created by Romain Mullot on 02/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public struct ImagesJSON: Codable {
    public var small: String?
    public var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case small
        case thumb
    }
    
    public init(small: String = "", thumb: String = "") {
        self.small = small
        self.thumb = thumb
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }
    
}
