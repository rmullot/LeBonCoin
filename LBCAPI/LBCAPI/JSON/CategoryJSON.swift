//
//  CategoryJSON.swift
//  LBCAPI
//
//  Created by Romain Mullot on 02/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

public struct CategoryJSON: Codable {
    public var idCategory: Int = 0
    public var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case idCategory = "id"
        case name = "name"
    }
    
    public init(idCategory: Int = 0, name: String = "") {
        self.idCategory = idCategory
        self.name = name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idCategory = try values.decode(Int.self, forKey: .idCategory)
        name = try values.decode(String.self, forKey: .name)
    }
    
}
