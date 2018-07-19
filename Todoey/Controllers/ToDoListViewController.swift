//
//  ViewController.swift
//  Todoey
//
//  Created by Brian Lee on 7/18/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var itemArray = [Item("Buy books"), Item("Apply for jobs"), Item("Save the world!")]

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let toDoList = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = toDoList
//        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        let currentItem = itemArray[indexPath.row]
        cell.textLabel?.text = currentItem.getTitle()
        cell.accessoryType = currentItem.isDone() ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)

        itemArray[indexPath.row].toggleDone()
        
        if currentCell?.accessoryType == .checkmark {
            currentCell?.accessoryType = .none
        } else {
            currentCell?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addListItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New To-do Item", message: "", preferredStyle: .alert)
        let addItem = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.itemArray.append(Item(alertTextField.text!))
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
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

}

