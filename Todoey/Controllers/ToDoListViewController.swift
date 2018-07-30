//
//  ViewController.swift
//  Todoey
//
//  Created by Brian Lee on 7/18/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var toDoItems: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataFilePath!)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)

        if let currentItem = toDoItems?[indexPath.row] {
            cell.textLabel?.text = currentItem.title
            cell.accessoryType = currentItem.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Item Added"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)

        if let currentItem = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    currentItem.done = !currentItem.done
                }
            } catch {
                print("Error updating the item: \(error)")
            }
        }
    
        if currentCell?.accessoryType == .checkmark {
            currentCell?.accessoryType = .none
        } else {
            currentCell?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addListItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let addItem = UIAlertAction(title: "Add", style: .default) { (action) in

            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.createdDate = Date()
                        newItem.title = alertTextField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error adding item: \(error)")
                }

            }

            self.tableView.reloadData()
        }
        
        alert.addAction(addItem)
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            //Store the reference so it is accessible inside the closure
            alertTextField = textField
        }

        present(alert, animated: true, completion: nil)

    }

    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }

}

//MARK: - Searchbar delegate methods

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "createdDate", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count == 0) {
            loadItems()
            tableView.reloadData()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

