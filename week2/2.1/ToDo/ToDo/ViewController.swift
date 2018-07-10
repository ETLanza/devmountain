//
//  ViewController.swift
//  ToDo
//
//  Created by Eric Lanza on 7/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

struct Todo {
    var name: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    var todos = [
        Todo(name: "Do the dishes"),
        Todo(name: "Record a lesson"),
        Todo(name: "Mow the law")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions
    @IBAction func didPressAddButton(_ sender: Any) {
        let indexPath = IndexPath(row: todos.count, section: 0)
        todos.append(Todo(name: "Eat a JDawg"))
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func didPressEditButton(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressEditButton(_:)))
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Table View Data Sources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        
        cell.textLabel?.text = todos[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            break
        case .none:
            break
        }
    }
}
