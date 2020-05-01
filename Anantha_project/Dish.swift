//
//  Fruit.swift
//  mehd8970_a4
//
//  Created by Anantha on 2020-02-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Dish: NSObject, NSCoding {
    
    let dishImage:UIImage
    let dishName:String
    var ingredientList = [Ingredients]()
    var noOfServings: Int
    
    
    struct PropertyKey {
        static let dishImage = "dishImage"
        static let dishName = "dishName"
        static let ingredientList = "ingredientList"
        static let noOfServings = "noOfServings"
    }
    
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(dishName, forKey: PropertyKey.dishName)
        aCoder.encode(dishImage, forKey: PropertyKey.dishImage)
        aCoder.encode(ingredientList, forKey: PropertyKey.ingredientList)
        aCoder.encode(noOfServings, forKey: PropertyKey.noOfServings)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
     
        guard let nameDecoded = aDecoder.decodeObject(
            forKey: PropertyKey.dishName) as? String
            else {
                os_log("Unable to decode the name for a dish",
                       log:OSLog.default,type:.debug )
                return nil
        }
        let imageDecoded = (aDecoder.decodeObject(forKey: PropertyKey.dishImage) as? UIImage)!
        let ingredientListDecoded = (aDecoder.decodeObject(forKey: PropertyKey.ingredientList) as! [Ingredients])
        
        let noOfServingsDecoded = (aDecoder.decodeInteger(forKey: PropertyKey.noOfServings))
        
        self.init(dishName:nameDecoded, dishImage:imageDecoded, ingredientList:ingredientListDecoded, noOfServings:noOfServingsDecoded)
        
    }
    init?(dishName: String, dishImage: UIImage,ingredientList:[Ingredients],noOfServings:Int){
        self.dishImage = dishImage
        self.dishName = dishName
        self.ingredientList = ingredientList
        self.noOfServings = noOfServings
    }
    
    func getDishImage() -> UIImage {
        return self.dishImage
    }
    
    func getDishName() -> String {
        return self.dishName
    }
    
    func getNoOfServings() -> Int {
        return self.noOfServings
    }
    
    func setNoOfServings(count:Int){
        self.noOfServings = count
    }
    
    func getIngredientList() -> [Ingredients] {
        return self.ingredientList
    }
    
    func addToIngredients(ingredient:Ingredients) {
        self.ingredientList.append(ingredient)
    }
 
}
