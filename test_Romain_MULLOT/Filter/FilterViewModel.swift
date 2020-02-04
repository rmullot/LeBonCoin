//
//  FilterViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation

protocol FilterViewModelProtocol: AnyObject {
    var delegate: FilterViewModelDelegate? { get set }
}

protocol FilterViewModelDelegate: AnyObject {
    func didTapCancel(viewModel: FilterViewModelProtocol)
    func didTapValidate(viewModel: FilterViewModelProtocol)
}

final class FilterViewModel: FilterViewModelProtocol {
    weak var delegate: FilterViewModelDelegate?
}
