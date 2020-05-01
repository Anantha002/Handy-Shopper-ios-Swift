//
//  SharingFruitCollection.swift
//  mehd8970_a4
//
//  Created by Anantha on 2020-02-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import UIKit

class SharingDishCollection {
    static let sharedDishCollection = SharingDishCollection()
    let fileName = "finalProject.archive"
    private let rootKey = "rootKey"
    var dishCollection : DishCollection?
    
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory.appendingPathComponent(fileName) as String
    }
    
    func loadDishCollection()  {
        print("loadFruitCollection .... starting")
        let filePath = self.dataFilePath()
        if (FileManager.default.fileExists(atPath: filePath)) {
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            SharingDishCollection.sharedDishCollection.dishCollection = unarchiver.decodeObject(forKey: rootKey) as? DishCollection
            unarchiver.finishDecoding()
        }
        //default recipes which will be loaded
        if(SharingDishCollection.sharedDishCollection.dishCollection == nil){
            SharingDishCollection.sharedDishCollection.dishCollection = DishCollection()
            let burritoImage: UIImage = UIImage(named: "burrito")!
            let burritoIngredients1 = Ingredients(ingredientName: "Uncooked wheat flour", ingredientQuantity: 120)!
            let burritoIngredients2 = Ingredients(ingredientName: "Beans", ingredientQuantity: 100)!
            let burritoIngredients3 = Ingredients(ingredientName: "Cheese", ingredientQuantity: 80)!
            let burritoIngredients4 = Ingredients(ingredientName: "Tomato", ingredientQuantity: 100)!
            let burritoIngredients5 = Ingredients(ingredientName: "Onions", ingredientQuantity: 110)!
            let burritoIngredients6 = Ingredients(ingredientName: "Chicken meat", ingredientQuantity: 200)!
            SharingDishCollection.sharedDishCollection.dishCollection?.collection.append(Dish(dishName: "Burrito", dishImage: burritoImage, ingredientList: [burritoIngredients1,burritoIngredients2,burritoIngredients3,burritoIngredients4,burritoIngredients5,burritoIngredients6],noOfServings: 0)!)
            
            
            let pastaImage: UIImage = UIImage(named: "pasta")!
            let pastaIngredients1 = Ingredients(ingredientName: "Uncooked pasta", ingredientQuantity: 130)!
            let pastaIngredients2 = Ingredients(ingredientName: "Cheese", ingredientQuantity: 30)!
            let pastaIngredients3 = Ingredients(ingredientName: "Tomato", ingredientQuantity: 90)!
            let pastaIngredients4 = Ingredients(ingredientName: "Onions", ingredientQuantity: 100)!
            SharingDishCollection.sharedDishCollection.dishCollection?.collection.append(Dish(dishName: "Pasta", dishImage: pastaImage, ingredientList: [pastaIngredients1,pastaIngredients2,pastaIngredients3,pastaIngredients4],noOfServings: 0)!)
            
            
            let chickenRiceImage: UIImage = UIImage(named: "chickenRice")!
            let chickenRiceIngredients1 = Ingredients(ingredientName: "Chicken meat", ingredientQuantity: 150)!
            let chickenRiceIngredients2 = Ingredients(ingredientName: "Rice", ingredientQuantity: 190)!
            let chickenRiceIngredients3 = Ingredients(ingredientName: "Tomato", ingredientQuantity: 60)!
            let chickenRiceIngredients4 = Ingredients(ingredientName: "Onions", ingredientQuantity: 100)!
            let chickenRiceIngredients5 = Ingredients(ingredientName: "spice powder", ingredientQuantity: 30)!
            let chickenRiceIngredients6 = Ingredients(ingredientName: "Oil", ingredientQuantity: 50)!
            SharingDishCollection.sharedDishCollection.dishCollection?.collection.append(Dish(dishName: "Chicken Rice", dishImage: chickenRiceImage, ingredientList: [chickenRiceIngredients1,chickenRiceIngredients2,chickenRiceIngredients3,chickenRiceIngredients4,chickenRiceIngredients5,chickenRiceIngredients6],noOfServings: 0)!)
            
            
            let pizzaImage: UIImage = UIImage(named: "pizza")!
                       let pizzaIngredients1 = Ingredients(ingredientName: "Flour", ingredientQuantity: 100)!
                       let pizzaIngredients2 = Ingredients(ingredientName: "Cheese", ingredientQuantity: 200)!
                       let pizzaIngredients3 = Ingredients(ingredientName: "chicken", ingredientQuantity: 80)!
                       let pizzaIngredients4 = Ingredients(ingredientName: "Onions", ingredientQuantity: 30)!
                       let pizzaIngredients5 = Ingredients(ingredientName: "Pizza tomato sauce", ingredientQuantity: 200)!
                       let pizzaIngredients6 = Ingredients(ingredientName: "Bassil", ingredientQuantity: 20)!
                       let pizzaIngredients7 = Ingredients(ingredientName: "Olives", ingredientQuantity: 25)!
                       let pizzaIngredients8 = Ingredients(ingredientName: "Mushrooms", ingredientQuantity: 25)!
                       let pizzaIngredients9 = Ingredients(ingredientName: "Green peppers", ingredientQuantity: 10)!
                       let pizzaIngredients10 = Ingredients(ingredientName: "Pineapple", ingredientQuantity: 30)!
                       let pizzaIngredients11 = Ingredients(ingredientName: "Spinach", ingredientQuantity: 25)!
                       let pizzaIngredients12 = Ingredients(ingredientName: "Capsicum", ingredientQuantity: 30)!
            SharingDishCollection.sharedDishCollection.dishCollection?.collection.append(Dish(dishName: "Pizza", dishImage: pizzaImage, ingredientList: [pizzaIngredients1,pizzaIngredients2,pizzaIngredients3,pizzaIngredients4,pizzaIngredients5,pizzaIngredients6,pizzaIngredients7,pizzaIngredients8,pizzaIngredients9,pizzaIngredients10,pizzaIngredients11,pizzaIngredients12],noOfServings: 0)!)
            
        }
        print("end of load")
    }
    
    func  saveFruitCollection() {
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingDishCollection.sharedDishCollection.dishCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
    
    
    
}
