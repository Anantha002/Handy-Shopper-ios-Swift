//
//  ShoppingListViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let simpleTableIdentifier = "ingredients-list-identifier"
    var tableData = [Ingredients]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        tableData = SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection ?? []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "Purchased") {(action, sourceView, completionHandler) in
        SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection?.collection.append(self.tableData[indexPath.row])
            self.tableData.remove(at: indexPath.row)
            SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection = IngredientCollection();
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       tableData.count
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
         
         if(cell == nil){
             cell = UITableViewCell(style: UITableViewCell.CellStyle.value1 , reuseIdentifier: simpleTableIdentifier)
         }
         
         cell?.textLabel?.text = tableData[indexPath.row].getIngredientName()
         
         cell?.detailTextLabel?.text = String(tableData[indexPath.row].getIngredientQuantity())
         
         return cell!
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
