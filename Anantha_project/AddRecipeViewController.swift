//
//  AddRecipeViewController.swift
//  Anantha_Project
//
//  Created by Anantha on 2020-03-19.
//  Copyright © 2020 Anantha. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableData = [Ingredients]()
    
    let simpleTableIdentifier = "ingredient-identifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
 
    @IBOutlet weak var dishName: UITextField!
    var dish: Dish?
    
    func getDish() -> Dish{
        return self.dish!
    }
    
    @IBAction func addIngredientsToRecipe(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Ingredient", message: "Enter name and quantity", preferredStyle: .alert)

        alert.addTextField()
        alert.addTextField(configurationHandler: { textField in
            textField.keyboardType = .numberPad
        })

        alert.textFields![0].placeholder = "Enter the ingredient name"
        alert.textFields![1].placeholder = "Enter the quantity"


        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {action in
            
            if( alert.textFields![0].text! != "" && (Int(alert.textFields![1].text!) ?? 0) >= 1){
                let ingredient = Ingredients(ingredientName: alert.textFields![0].text!, ingredientQuantity:Int(alert.textFields![1].text!) ?? 0)
                
                self.tableData.append(ingredient!)
                    self.tableView.reloadData()
            }else{
                let errorMessage = UIAlertController(title: "Incorrect input", message: "Please enter valid input", preferredStyle: .alert)
                errorMessage.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(errorMessage, animated: true)
            }
        }))

       self.present(alert, animated: true)
       
        
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
    
    // prepare to send the fruit to the TableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let nameOfDish = dishName.text!
        let dishImage = dishImageView?.image
        dish = Dish(dishName: nameOfDish, dishImage: dishImage!, ingredientList: tableData,noOfServings: 0)!
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
    }
    
    @objc func dismissKeyboard(){
       view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        view.addGestureRecognizer(Tap)
        
        
        saveButton.isEnabled = false
        self.dishName.delegate = self
        
        
        dishName.addTarget(self, action: #selector(AddRecipeViewController.fruitTextFieldDidChange(_:)), for:
                   UIControl.Event.editingChanged)
        
        let tapDishImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dishImageTapped(tapGestureRecognizer:)))

        dishImageView.isUserInteractionEnabled = true

        dishImageView.addGestureRecognizer(tapDishImageGestureRecognizer)

        self.dishName.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    @objc func fruitTextFieldDidChange(_ textField: UITextField){
       if(dishName.text != ""){
           self.navigationItem.rightBarButtonItem!.isEnabled = true;
       }else{
           self.navigationItem.rightBarButtonItem!.isEnabled = false;
       }
   }
    
    @objc func dishImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
      {
          _ = tapGestureRecognizer.view as! UIImageView
          let fruitImagePickerController = UIImagePickerController()
          
          fruitImagePickerController.sourceType = .photoLibrary
          
          fruitImagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
          present(fruitImagePickerController, animated: true, completion: nil)
      }
    
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        dishImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any]{
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true);
       
        return false;
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
