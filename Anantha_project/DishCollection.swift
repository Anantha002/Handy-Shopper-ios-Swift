//
//  FruitCollection.swift
//  mehd8970_a4
//
//  Created by Anantha on 2020-02-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import UIKit


class DishCollection:NSObject,NSCoding{
    var collection = [Dish]()
    var current: Int = 0
    let collectionKey = "collectionKey"
    let currentKey = "currentKey"
    
    override init(){
        super.init()
        
    }
        
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        collection = (decoder.decodeObject(forKey: collectionKey) as? [Dish])!
        current = (decoder.decodeInteger(forKey: currentKey))
    }
    
    func encode(with acoder: NSCoder){
        acoder.encode(collection,forKey: collectionKey)
        acoder.encode(current,forKey: currentKey)
    }
    
    func currentDish() -> Dish {
        let dish = (collection[current])
        return dish
    }
    
    func appendDishToCollection(dishObject dish: Dish){
        collection.append(dish)
    }
          
    func deleteCurrentDish(dishIndex index: Int) {
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
