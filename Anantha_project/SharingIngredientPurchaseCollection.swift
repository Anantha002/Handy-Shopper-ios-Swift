//
//  SharingIngredientPurchaseCollection.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-31.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation

class SharingIngredientPurchaseCollection {
    static let sharedIngredientPurchaseCollection = SharingIngredientPurchaseCollection()
    let fileName = "finalProjectIngredientPurchase.archive"
    private let rootKey = "rootPurchasedKey"
    var ingredientCollection : IngredientCollection?
    
    
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
            SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection = unarchiver.decodeObject(forKey: rootKey) as? IngredientCollection
            unarchiver.finishDecoding()
        }
        if(SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection == nil){
            SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection = IngredientCollection()
        print("Is empty")
          
        }
        print("end of load")
    }
    
    func  saveFruitCollection() {
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingIngredientPurchaseCollection.sharedIngredientPurchaseCollection.ingredientCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
    
}
