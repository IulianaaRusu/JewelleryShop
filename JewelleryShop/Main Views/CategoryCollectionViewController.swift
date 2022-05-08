//
//  CategoryCollectionViewController.swift
//  JewelleryShop
//
//  Created by user217572 on 5/7/22.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {

    
    //MARK: Vars
    var categoryArray: [Category] = []
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private let itemsPerRow: CGFloat = 1
    private let itemsTotal: CGFloat = 4

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
//    MARK: used only once
//        createCategorySet()
                
//    MARK: download
//        downloadCategoriesFromFirebase{ (allCategories) in
//            print("callback is completed")
//         }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadCategories()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.generateCell(categoryArray[indexPath.row])
        print("in fuuunct")
        return cell
    }

    //MARK: Download categories
    private func loadCategories(){
        
        downloadCategoriesFromFirebase { (allCategories) in
            print("we have", allCategories.count)
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }
    
}


extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let paddingSpaceR = sectionInsets.top * (itemsTotal + 1)
        let availableWidth = view.frame.width - paddingSpace
        let availableHeight = view.frame.height - paddingSpaceR
		
		print("paddR=", paddingSpaceR)
		print("avvH=", availableHeight)
		print("aavW=", availableWidth)
		print("hperItem=", availableHeight/paddingSpaceR)
        let widthPerItem = availableWidth / itemsPerRow
//let heightPerItem = availableHeight / itemsTotal
        
		return CGSize(width: view.frame.width, height: (view.frame.height+20)/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
