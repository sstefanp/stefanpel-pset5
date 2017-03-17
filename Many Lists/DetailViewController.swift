//
//  DetailViewController.swift
//  Many Lists
//
//  Created by Stefan Pel on 07-03-17.
//  Copyright © 2017 Stefan Pel. All rights reserved.
//

import UIKit
import SQLite

class DetailViewController: UITableViewController {

    var todoItems: [TodoItem] = []
    var todoList: TodoList?
    var database: Connection?
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewItem(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func reloadData() {
        // Retrieve items from list.
        self.todoItems = self.todoList?.items ?? []
        self.tableView.reloadData()
    }
    
    func insertNewItem(_ sender: Any) {
        let alert = UIAlertController(title: "Enter new item", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        
        // Create new list with this name.
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            
            guard let field = alert.textFields?.first else { return }
            
            guard let text = field.text else { return }
            self.todoList?.addItem(text: text)
            self.reloadData()
            
            print (field.text! as String)
        }))
        
        alert.addTextField { (field) in
            
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = self.todoItems[indexPath.row].name
        
        return cell
    }
    
}

