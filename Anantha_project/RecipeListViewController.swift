//
//  FirstViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit


class recipeCustomCell: UITableViewCell{
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
}

class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let simpleTableIdentifier = "recipe-cell-identifier"
    var tableData = [Dish]()
    var filteredTableData = [Dish]()
    var sharedDishCollection : DishCollection?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTableData.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard !searchText.isEmpty else {
            filteredTableData = tableData
            tableView.reloadData()
            return
        }

        filteredTableData = tableData.filter({ dish -> Bool in
            dish.getDishName().lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        return
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as? recipeCustomCell
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default , reuseIdentifier: simpleTableIdentifier) as? recipeCustomCell
        }
        
        cell?.recipeImage.image = filteredTableData[indexPath.row].getDishImage()
        
        
        cell?.recipeName.text = filteredTableData[indexPath.row].getDishName()
        
        return cell!
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var _ = SharingDishCollection()
        var _ = SharingIngredientPurchaseCollection()
        var _ = SharingIngredientCollection()
        
        SharingIngredientCollection.sharedIngredientCollection.loadDishCollection()
        SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.loadDishCollection()
        SharingDishCollection.sharedDishCollection.loadDishCollection()
        sharedDishCollection = SharingDishCollection.sharedDishCollection.dishCollection
        // Do any additional setup after loading the view.
        updateDishData()
    }
    
    func updateDishData(){
        tableData = sharedDishCollection!.collection
        filteredTableData = tableData
        tableView.reloadData()
   }

    @IBAction func unwindToTableView(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddRecipeViewController{
            let dishData = sourceViewController.getDish()
            SharingDishCollection.sharedDishCollection.dishCollection?.collection.append(dishData)
   
            updateDishData()
           }
       }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        sharedDishCollection?.setCurrentIndex(to: indexPath.row)
        if let index = self.tableData.firstIndex(of: self.filteredTableData[indexPath.row]) {
            performSegue(withIdentifier: "showDetail", sender:((indexValue : index, tableData: tableData )))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? RecipeDetailsViewController  {
               destination.initWithData(sender)
           }
       }
       

}

