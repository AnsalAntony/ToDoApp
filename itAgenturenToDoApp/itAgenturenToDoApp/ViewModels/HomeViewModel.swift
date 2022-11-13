//
//  HomeViewModel.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 12/11/22.
//

import Foundation

final class HomeViewModel {
        
    var todoItems = [ToDoModel]()
    
    typealias CompletionHandler = () -> Void
    
    func takeTodoItems(completion: CompletionHandler){
        let savedTask = DatabaseHelper.shared.getAllToDoItems()
        todoItems.removeAll()
        todoItems.append(contentsOf: savedTask)
       completion()
    }
    
}
