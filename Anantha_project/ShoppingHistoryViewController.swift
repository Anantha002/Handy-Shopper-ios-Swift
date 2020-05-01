//
//  ShoppingHistoryViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit

class ShoppingHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableData = [Ingredients]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        tableData = SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection?.collection ?? []
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
