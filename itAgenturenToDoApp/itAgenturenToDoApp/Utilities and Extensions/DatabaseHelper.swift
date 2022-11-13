//
//  DatabaseHelper.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import Foundation
import RealmSwift
import UIKit


class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    /// Open the local-only default realm
    private var realm = try! Realm()
    
    func getDatabasePath() -> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveToDoItems(todoModel: ToDoModel){
        try! realm.write({
            realm.add(todoModel)
        })
    }
    
    func updateToDo(oldTodo: ToDoModel, newTodo: ToDoModel){
        try! realm.write{
            oldTodo.title = newTodo.title
            oldTodo.toDoDescription = newTodo.toDoDescription
            oldTodo.time = newTodo.time
            oldTodo.date = newTodo.date
            oldTodo.daily = newTodo.daily
            oldTodo.weekly = newTodo.weekly
            oldTodo.alaram = newTodo.alaram
        }
    }
    
    func deleteToDoItems(todoModel: ToDoModel){
        try! realm.write{
            realm.delete(todoModel)
        }
    }
    
    func getAllToDoItems() -> [ToDoModel]{
        return Array(realm.objects(ToDoModel.self))
    }
    
}
