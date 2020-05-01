//
//  SharingIngredientCollection.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-20.
//  Copyright © 2020 Anantha. All rights reserved.
//

import Foundation
import UIKit

class SharingIngredientCollection {
    static let sharedIngredientCollection = SharingIngredientCollection()
    let fileName = "finalProjectIngredient.archive"
    private let rootKey = "rootIngredientsKey"
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
            SharingIngredientCollection.sharedIngredientCollection.ingredientCollection = unarchiver.decodeObject(forKey: rootKey) as? IngredientCollection
            unarchiver.finishDecoding()
        }
        if(SharingIngredientCollection.sharedIngredientCollection.ingredientCollection == nil){
            SharingIngredientCollection.sharedIngredientCollection.ingredientCollection = IngredientCollection()
        print("Is empty")
          
        }
        print("end of load")
    }
    
    func  saveFruitCollection() {
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingIngredientCollection.sharedIngredientCollection.ingredientCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
    

      
}
