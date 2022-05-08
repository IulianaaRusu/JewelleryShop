//
//  CategoryCollectionViewCell.swift
//  JewelleryShop
//
//  Created by user217572 on 5/7/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func generateCell(_ category: Category){
        nameLabel.text = category.name
        imageView.image = category.image    }
}
