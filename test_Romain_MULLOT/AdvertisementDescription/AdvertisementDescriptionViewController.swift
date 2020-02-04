//
//  AdvertisementDescriptionViewController.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 04/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit

final class AdvertisementDescriptionViewController: UIViewController {
    
    private let viewModel: AdvertisementDescriptionViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    init(viewModel: AdvertisementDescriptionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AdvertisementDescriptionViewController {
    
    func setup() {
        view.isOpaque = true
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        
    }
    
    func setupConstraints() {
        
    }
}
