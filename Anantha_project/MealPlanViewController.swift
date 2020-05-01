//
//  SecondViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit
let simpleTableIdentifier = "meal-reuse-identifier"
class CustomCell : UITableViewCell{
    
    @IBOutlet weak var dishImage: UIImageView!
    
   
    @IBOutlet weak var decrementServings: UIButton!
    @IBOutlet weak var incrementServings: UIButton!
    @IBOutlet weak var servingsCount: UILabel!
    @IBOutlet weak var dishName: UILabel!
}
class MealPlanViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource  {
     var tableData = [Dish]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = SharingDishCollection.sharedDishCollection.dishCollection!.collection
        tableView.reloadData()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        tableData = SharingDishCollection.sharedDishCollection.dishCollection!.collection
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          tableData.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? CustomCell
          
          if(cell == nil){
              cell = UITableViewCell(style: UITableViewCell.CellStyle.default , reuseIdentifier: simpleTableIdentifier) as? CustomCell
          }
          
        cell?.dishImage?.image = tableData[indexPath.row].getDishImage()
          
        cell?.dishName?.text = tableData[indexPath.row].getDishName()
        
        cell?.servingsCount?.text = String(tableData[indexPath.row].getNoOfServings())
        
        cell?.incrementServings.tag = indexPath.row
        cell?.decrementServings.tag = indexPath.row
        
        cell?.incrementServings.addTarget(self, action: #selector(MealPlanViewController.incrementServingCount(sender:)), for:
            UIControl.Event.touchUpInside)
        
        cell?.decrementServings.addTarget(self, action: #selector(MealPlanViewController.decrementServingCount(sender:)), for:
        UIControl.Event.touchUpInside)
          return cell!
      }
    
    @objc func incrementServingCount(sender: UIButton){
        tableData[sender.tag].setNoOfServings(count: tableData[sender.tag].getNoOfServings() + 1)
        tableView.reloadData()
    }
    
    @objc func decrementServingCount(sender: UIButton){
        if(tableData[sender.tag].getNoOfServings() - 1 >= 0){
            tableData[sender.tag].setNoOfServings(count: tableData[sender.tag].getNoOfServings() - 1)
        }
        tableView.reloadData()
    }

    @IBAction func confirmPurchaseListItems(_ sender: Any) {
        var localTableData = [Ingredients]()
        
        for dish in tableData{
            if(dish.noOfServings > 0){
                for ingredient in dish.getIngredientList(){
                    
                    var ingredientNotPresent = true
                    
                    for tableIngredient in localTableData{
                        if tableIngredient.ingredientName == ingredient.ingredientName{
                            tableIngredient.setIngredientQuantity(quantity: (tableIngredient.ingredientQuantity + (ingredient.ingredientQuantity * dish.noOfServings)))
                          
                            ingredientNotPresent = false
                        }
                    }
                    if(ingredientNotPresent == true){
                       
                        let totalQuantity = Ingredients(ingredientName: ingredient.ingredientName, ingredientQuantity: ingredient.ingredientQuantity * dish.noOfServings)
                        
                        localTableData.append(totalQuantity!)
                    }
                }
            }
        }
        
        
        
        for dishItem in localTableData{
            var presenceFlag = true
            if (SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection.count)! > 0 {
                for i in 0...(SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection.count)! - 1{
                    
                    if(SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection[i].getIngredientName() == dishItem.getIngredientName()){
                            presenceFlag = false
                        SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection[i].setIngredientQuantity(quantity:  (SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection[i].getIngredientQuantity())! + dishItem.getIngredientQuantity())
                    }
                    
                }
            }
            
            if(presenceFlag){
                SharingIngredientCollection.sharedIngredientCollection.ingredientCollection?.collection.append(dishItem)
            }
        }
        
        for i in 0...tableData.count-1{
            tableData[i].setNoOfServings(count: 0)
        }
        
        tableView.reloadData()
    }
    
}

