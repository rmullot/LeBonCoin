//
//  FilterViewModel.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import LBCBridge

protocol FilterViewModelProtocol: AnyObject {
    var delegate: FilterViewModelDelegate? { get set }
    func didTapCancel()
    func didTapValidate()
    var categoriesCount: Int { get }
    func getName(index: Int) -> String
    func isSelected(index: Int) -> Bool
    func didSelectCategory(index: Int)
    func refreshCategoriesList(completionHandler: @escaping ()->())
    init(categoryService: CategoryService)
}

protocol FilterViewModelDelegate: AnyObject {
    func didTapCancel(viewModel: FilterViewModelProtocol)
    func didTapValidate(viewModel: FilterViewModelProtocol)
}

final class FilterViewModel: FilterViewModelProtocol {
    
    weak var delegate: FilterViewModelDelegate?
    
    private var categories: [LBCBridge.Category]? = nil
    private var selectedCategories: [Int] = []
    private let categoryService: CategoryService
    
    var categoriesCount: Int {
        return categories?.count ?? 0
    }
    
    init(categoryService: CategoryService) {
        self.categoryService = categoryService
    }
    
    func didTapCancel() {
        delegate?.didTapCancel(viewModel: self)
    }
    
    func didTapValidate() {
        categoryService.selectedCategories = selectedCategories
        delegate?.didTapValidate(viewModel: self)
    }
    
    func didSelectCategory(index: Int) {
        guard let category = getCategory(index: index) else { return }
        
        if let index = selectedCategories.firstIndex(of: category.idCategory) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category.idCategory)
        }
    }
    
    func getName(index: Int) -> String {
        return getCategory(index: index)?.name ?? ""
    }
    
    func isSelected(index: Int) -> Bool {
        guard let category = getCategory(index: index) else { return false }
        return selectedCategories.contains(category.idCategory)
    }
    
    func refreshCategoriesList(completionHandler: @escaping ()->()) {
        categoryService.getCategories { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let categories):
                strongSelf.categories = categories ?? []
                strongSelf.selectedCategories = strongSelf.categoryService.selectedCategories
                completionHandler()
            default: completionHandler()
            }
        }
    }
}

private extension FilterViewModel {
    
    func getCategory(index: Int) -> LBCBridge.Category? {
        guard categories?.isValidIndex(index) ?? false, let category = categories?[index] else { return nil }
        return category
    }
}
