//
//  TodoManager.swift
//  Many Lists
//
//  Created by Stefan Pel on 07-03-17.
//  Copyright © 2017 Stefan Pel. All rights reserved.
//

import Foundation
import SQLite

class TodoManager {
    
    // Setting up database.
    var database: Connection?
    
    // Table for todolists.
    static let todolists = Table("todolists")
    static let listID = Expression<Int>("listID")
    static let todolist = Expression<String>("todolist")
    
    // Table for todoitems.
    static let todoitems = Table("todoitems")
    static let itemID = Expression<Int>("itemID")
    static let todoitem = Expression<String>("todoitem")
    static let completed = Expression<Bool>("completed")
    
    init() {
        setupDatabase()
    }
    
    private func setupDatabase() {
        defer {
            if self.database == nil {
                // Error handling.
            }
        }
        
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return
        }
        
        do {
            database = try Connection("\(path)/db.sqlite3")
            createListsTable()
        } catch let error {
            // Error handling.
        }
    }
    private func createListsTable() {
        do {
            try database?.run(TodoManager.todolists.create(ifNotExists: true) { t in
                t.column(TodoManager.listID, primaryKey: .autoincrement)
                t.column(TodoManager.todolist)
            })
        }
        catch let error {
            // Error handling.
        }
    }
    
    private func createToDoItem() {
        do {
            try database?.run(TodoManager.todoitems.create(ifNotExists: true) { t in
                t.column(TodoManager.itemID, primaryKey: .autoincrement)
                t.column(TodoManager.todoitem)
                t.column(TodoManager.completed)
            })
        }
        catch {
            // Error handling
        }
    }
    
//    func getAllLists(listId: Int, listName: String) throws -> TodoList{
//        do {
//            for item in try! database?.prepare(listID.filter(self.list) ==  )
//        }
//    }
    
    
    func addList(name: String) {
        
        let listToAdd = TodoManager.todolists.insert(TodoManager.todolist <- name)
        
        do {
            try database?.run(listToAdd)
        }
        catch let error {
            // Error handling.
        }
    }
    
    
    var lists: [TodoList] {
        get {
            guard let results = try? database?.prepare(TodoManager.todolists) else { return [] }
            
            var lists: [TodoList] = []
            
            for row in results! {
                lists.append(TodoList(row: row, in: self.database!))
            }
            
            return lists
        }
    }
}

let todoManager = TodoManager()
//print(todoManager.lists)



