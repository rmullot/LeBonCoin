//
//  AdvertisementModelTest.swift
//  test_Romain_MULLOTTests
//
//  Created by Romain Mullot on 07/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCBridge
@testable import test_Romain_MULLOT

final class AdvertisementServiceMock: AdvertisementServiceProtocol {
    
    let advertisement = Advertisement(idAdvertisement: 1089188763, categoryName: "Livres/CD/DVD", idCategory: 7, title: "After effects 7.0", description: "Vends le livre  classroom in a book  d'after effects 7.0 pour apprendre le logiciel.", price: 5.00, creationDate: "2019-11-05T15:56:32+0000".iso8601Date, imageUrls: ["small": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/b044c1a3ff14881709f4a53722b754791a26bb0e.jpg",
    "thumb": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/b044c1a3ff14881709f4a53722b754791a26bb0e.jpg"], isUrgent: true)
    
    func getAdvertisementsWithFilter(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void) {
        return completionHandler(.success([advertisement]))
    }
    
    func refreshAdvertisements(completionHandler: @escaping (Result<[Advertisement]?, Error>) -> Void) {
        return completionHandler(.success([advertisement]))
    }
    
}
