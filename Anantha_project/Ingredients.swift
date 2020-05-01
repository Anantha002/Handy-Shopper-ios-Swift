//
//  Ingredients.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import os.log

class Ingredients : NSObject, NSCoding  {
    
    
    var ingredientQuantity:Int
    let ingredientName:String
    
    struct PropertyKey {
        static let ingredientQuantity = "ingredientQuantity"
        static let ingredientName = "ingredientName"
    }

    func encode(with aCoder: NSCoder){
        print("ingredient name", ingredientName)
        print("ingredient qty", ingredientQuantity)
        aCoder.encode(ingredientQuantity, forKey: PropertyKey.ingredientQuantity)
        aCoder.encode(ingredientName, forKey: PropertyKey.ingredientName)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let ingredientNameDecoded = aDecoder.decodeObject(
            forKey: PropertyKey.ingredientName) as? String
            else {
                os_log("Unable to decode the name for a dish",
                       log:OSLog.default,type:.debug )
                return nil
        }


        let ingredientQuantityDecoded = (aDecoder.decodeInteger(forKey: PropertyKey.ingredientQuantity))

        self.init(ingredientName:ingredientNameDecoded, ingredientQuantity: ingredientQuantityDecoded )
    }
    init?(ingredientName: String, ingredientQuantity: Int){
        self.ingredientQuantity = ingredientQuantity
        self.ingredientName = ingredientName
    }
    
    func getIngredientQuantity() -> Int {
        return self.ingredientQuantity
    }

    func getIngredientName() -> String {
        return self.ingredientName
    }
    
    func setIngredientQuantity(quantity:Int){
        self.ingredientQuantity = quantity
    }
    
}

