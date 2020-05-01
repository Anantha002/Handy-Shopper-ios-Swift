//
//  IngredientCollection.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-20.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import UIKit


class IngredientCollection:NSObject,NSCoding{
    var collection = [Ingredients]()
    var current:Int = 0
    let collectionKey = "collectionKey"
    let currentKey = "currentKey"
    
    override init(){
        super.init()
        
    }
        
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        collection = (decoder.decodeObject(forKey: collectionKey) as? [Ingredients])!
        current = (decoder.decodeInteger(forKey: currentKey))
    }
    
    func encode(with acoder: NSCoder){
        acoder.encode(collection,forKey: collectionKey)
        acoder.encode(current,forKey: currentKey)
    }
    
    func currentIngredient() -> Ingredients {
        let ingredient = (collection[current])
        return ingredient
    }
    
    func appendIngredientToCollection(ingredientObject ingredient: Ingredients){
        collection.append(ingredient)
    }
          
    func deleteCurrentIngredient(ingredientIndex index: Int) {
        collection.remove(at: index)
    }
    
    func getCollectionSize()-> Int{
        return collection.count
    }
    
    func getCurrentIndex() -> Int {
        return current
    }

     func setCurrentIndex(to index: Int) {
        current = index
    }
}
