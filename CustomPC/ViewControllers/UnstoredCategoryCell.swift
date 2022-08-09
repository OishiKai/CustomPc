//
//  unstoredCategoryCell.swift
//  CustomPC
//
//  Created by Kai on 2022/08/07.
//

import UIKit

class UnstoredCategoryCell: UITableViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let cellIdentifier = String(describing: UnstoredCategoryCell.self)
    
    public func setup(category:Category) {
        categoryLabel.text = category.rawValue
//        if category == .graphicsCard {
//            categoryLabel.font = UIFont.systemFont(ofSize: 17)
//        }
        switch (category) {
        case .cpu:
            categoryImage.image = UIImage(named: "cpu")
        case .cpuCooler:
            categoryImage.image = UIImage(named: "cpuCooler")
        case .memory:
            categoryImage.image = UIImage(named: "memory")
        case .motherBoard:
            categoryImage.image = UIImage(named: "motherBoard")
        case .graphicsCard:
            categoryImage.image = UIImage(named: "graphicsCard")
        case .ssd:
            categoryImage.image = UIImage(named: "ssd")
        case .hdd:
            categoryImage.image = UIImage(named: "hdd")
        case .pcCase:
            categoryImage.image = UIImage(named: "pcCase")
        case .powerUnit:
            categoryImage.image = UIImage(named: "powerUnit")
        case .caseFan:
            categoryImage.image = UIImage(named: "caseFan")
        case .monitor:
            categoryImage.image = UIImage(named: "monitor")
        }
    }
}
