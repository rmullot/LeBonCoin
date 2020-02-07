//
//  CategoryCell.swift
//  test_Romain_MULLOT
//
//  Created by Romain Mullot on 07/02/2020.
//  Copyright © 2020 Romain Mullot. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)   // update UI
       accessoryType = selected ? .checkmark : .none
    }
    
    func config(viewModel: FilterViewModelProtocol, index: Int) {
        textLabel?.text = viewModel.getName(index: index)
        let isSelected = viewModel.isSelected(index: index)
        accessoryType = isSelected ? .checkmark : .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
        accessoryType = .none
    }

}

private extension CategoryCell {
    
    func setup() {
        isOpaque = true
        translatesAutoresizingMaskIntoConstraints = true
        selectionStyle = .none
        tintColor = .orange
    }
}
