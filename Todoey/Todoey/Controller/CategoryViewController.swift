//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Eduardo  Velez on 4/15/18.
//  Copyright © 2018 Eduardo  Velez. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - Data View Data Source Methods
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added Yet"
    
        guard let categoryColor = categories?[indexPath.row].backgroundColor else {fatalError()}
    
        cell.backgroundColor = UIColor(hexString: categoryColor)
    
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: categoryColor)!, returnFlat: true)
    
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.backgroundColor = UIColor.randomFlat.hexValue()
            
            self.saveCategories(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Save and Load Categories
    
    func saveCategories(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving contect \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()

    }
    
    //MARK: - Delete
    override func updateModel(at indexPath: IndexPath) {
    //handle action by updating model with deletion
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                }
                catch {
                    print("Error deliting category \(error)")
                }
            }
    }
    
}


