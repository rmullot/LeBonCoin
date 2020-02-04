//
//  AdvertisementDescriptionViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol AdvertisementDescriptionViewModelProtocol: AnyObject {
    var delegate: AdvertisementDescriptionViewModelDelegate? { get set }
}

protocol AdvertisementDescriptionViewModelDelegate: AnyObject {
    func didTapBack(viewModel: AdvertisementDescriptionViewModelProtocol)
}

final class AdvertisementDescriptionViewModel: AdvertisementDescriptionViewModelProtocol {
    weak var delegate: AdvertisementDescriptionViewModelDelegate?
}
