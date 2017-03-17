//
//  TodoItem.swift
//  Many Lists
//
//  Created by Stefan Pel on 14-03-17.
//  Copyright © 2017 Stefan Pel. All rights reserved.
//

import Foundation
import SQLite

class TodoItem {
    
    let id: Int
    let name: String
    let completed: Bool
    let database: Connection
    
    init(row: Row, in database: Connection) {
        self.id = row[TodoManager.itemID]
        self.name = row[TodoManager.todoitem]
        self.completed = row[TodoManager.completed]
        self.database = database
    }
    
    func delete() {
        
        
        // TODO
        
    }
    
    
    func complete() {
        
        // TODO
        
    }
    
}
