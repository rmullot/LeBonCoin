//
//  AdvertisementsViewModelTest.swift
//  test_Romain_MULLOTTests
//
//  Created by Romain Mullot on 07/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import XCTest
@testable import test_Romain_MULLOT

class AdvertisementsViewModelTest: XCTestCase {
    
    private var viewModel : AdvertisementsViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = AdvertisementsViewModel(advertisementService: AdvertisementServiceMock(), categoryService: CategoryServiceMock())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Advertisements_Count() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertEqual(self.viewModel.advertisementsCount, 1)
        })
    }
    
    func test_Get_Category() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertEqual(self.viewModel.getCategory(index: 0), "Livres/CD/DVD")
        })
    }
    
    func test_Get_Price() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertEqual(self.viewModel.getPrice(index: 0), "€5")
        })
    }
    
    func test_Get_Title() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertEqual(self.viewModel.getTitle(index: 0), "After effects 7.0")
        })
    }
    
    func test_Get_Is_Not_Urgent() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertFalse(self.viewModel.getIsNotUrgent(index: 0))
        })
    }
    
    func test_Get_Thumb_Image() {
        viewModel.refreshAdvertisementList(completionHandler: {
            XCTAssertEqual(self.viewModel.getThumbImage(index: 0), "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/b044c1a3ff14881709f4a53722b754791a26bb0e.jpg")
        })
    }
    
}
