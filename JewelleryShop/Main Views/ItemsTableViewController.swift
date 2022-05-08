//
//  ItemsTableViewController.swift
//  JewelleryShop
//
//  Created by user217572 on 5/8/22.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    //MARK: Vars
    var category: Category?
    var itemArray: [Item] = []
    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("selected category: ", category!.name as Any)
        
        tableView.tableFooterView = UIView()
        self.title = category?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if category != nil {
            loadItems()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

   

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToAddItemSeg"{
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
        }
    }

    //MARK: Load Items
    private func loadItems(){
        downloadItemsFromFirebase(category!.id) { (allItems) in
            print("We have \(allItems.count) items for this category")
            self.itemArray = allItems
            self.tableView.reloadData()
        }
    }
}
