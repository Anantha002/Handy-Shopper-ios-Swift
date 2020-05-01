//
//  RecipeDetailsViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let simpleTableIdentifier = "ingredients-details-identifier"
    
    var tableData = [Ingredients]()
    var theDish: Dish?
    var currentIndex: Int?
    var theDishCollection: [Dish]?

    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    
    func initWithData(_ fruitInformation: Any?){
      let recievedFruitTableData = fruitInformation as? ((indexValue : Int, tableData: [Dish]))
      currentIndex = recievedFruitTableData!.indexValue
      theDishCollection = recievedFruitTableData!.tableData
      theDish = recievedFruitTableData?.tableData[currentIndex!]
  }
    
 
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        currentIndex = (currentIndex! + 1) % theDishCollection!.count
        theDish = theDishCollection![currentIndex!]
        updateDishData(theDish!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         updateDishData(theDish!)
        // Do any additional setup after loading the view.
    }
    
    func updateDishData(_ dish: Dish){
       dishName.text = String(dish.dishName)
       dishImage.image = dish.dishImage
        tableData = (theDish?.getIngredientList())!
               tableView.reloadData()
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
