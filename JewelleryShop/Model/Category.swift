//
//  Category.swift
//  JewelleryShop


import Foundation
import UIKit

class Category {
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }
    
    // from JSON to Category
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
        
    }
}

// MARK: Download category from Firebase

func downloadCategoriesFromFirebase(completion: @escaping(_ categoryArray: [Category]) -> Void){
    
    var categoryArray: [Category] = []
    
    FirebaseReference(.Category).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return
        }
        
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents{
                print("created new category")
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
            }
        }
        completion(categoryArray)
    }
}



// MARK: Save category functions

func saveCategoryToFirebase(_ category: Category) {
    let id = UUID().uuidString //unique id
    category.id = id
    
    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}


//MARK: Helpers
// convert it into a dictionary
func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    return NSDictionary(objects: [category.id, category.name, category.imageName],
                        forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}

//use only one time
//func createCategorySet(){
//
//    let rings = Category(_name: "Rings", _imageName: "rings")
//    let earrings = Category(_name: "Earrings", _imageName: "earrings")
//    let necklaces = Category(_name: "Necklaces", _imageName: "necklaces")
//    let bracelets = Category(_name: "Bracelets", _imageName: "bracelets")
//
//    let arrayOfCategories = [rings, earrings, necklaces, bracelets]
//
//    for category in arrayOfCategories {
//        saveCategoryToFirebase(category)
//    }
//
//}
