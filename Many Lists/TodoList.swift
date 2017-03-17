//
//  TodoList.swift
//  Many Lists
//
//  Created by Stefan Pel on 14-03-17.
//  Copyright © 2017 Stefan Pel. All rights reserved.
//

import Foundation
import SQLite

class TodoList {
    let id: Int
    let name: String
    let database: Connection
    
    init(row: Row, in database: Connection) {
        self.id = row[TodoManager.listID]
        self.name = row[TodoManager.todolist]
        self.database = database
    }
    
    func addItem(text: String) {
        let itemtoAdd = TodoManager.todoitems.insert(TodoManager.todolist <- self.name, TodoManager.todoitem <- text)
        
        do {
            try database.run(itemtoAdd)
        }
        catch let error {
            print(error)
            // Error handling.
        }
    }
    
    func delete() throws {
        let items = TodoManager.todolists.where(TodoManager.listID == self.id)
        try database.run(items.delete())
    }
    
    var items: [TodoItem] {
        get {
            guard let results = try? self.database.prepare(TodoManager.todoitems.filter(TodoManager.todolist == self.name)) else { return [] }
            
            var items: [TodoItem] = []
            
            for row in results {
                items.append(TodoItem(row: row, in: self.database))
            }
            
            return items
        }
    }
}
