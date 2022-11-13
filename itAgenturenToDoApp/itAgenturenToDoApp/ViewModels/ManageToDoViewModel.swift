//
//  ManageToDoViewModel.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import Foundation
import UserNotifications


final class ManageToDoViewModel {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    typealias CompletionHandler = (_ success:Bool, _ message: String) -> Void

    func saveTodoItems(oldTodo: ToDoModel,editTodo: Bool,title: String, descrtpition: String, time: String, date: String, dailly: Bool, weekly: Bool, alaram: Bool, completion: CompletionHandler){
        if(title == ""){
            completion(false,Constants.titleErrorMsg)
            return
        }else if(time == ""){
            completion(false,Constants.timeErrorMsg)
            return
        }else if(!dailly && !weekly){
            completion(false,Constants.optiosErrorMsg)
            return
        }
        
        let todoModel = ToDoModel(title: title, toDoDescription: descrtpition, time: time, date: date, daily: dailly, weekly:weekly, alaram: alaram)
        let convertedTime = Formaters.shared.convertDateStringToDate(dateValue: time, formate: Constants.formateDateTime)
        setNotfication(title: title, descriptionTxt: descrtpition, weekly: weekly, time: convertedTime)
        if(editTodo){
            DatabaseHelper.shared.updateToDo(oldTodo: oldTodo, newTodo: todoModel)
            completion(true,Constants.todoUpdatedSucess)
        }else{
            DatabaseHelper.shared.saveToDoItems(todoModel: todoModel)
            completion(true,Constants.todoSavedSucess)
        }

    }
    func setNotfication(title: String, descriptionTxt: String,  weekly: Bool, time: Date){
        
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async{
                let title = title
                let message = descriptionTxt
                let date = time
                
                if(settings.authorizationStatus == .authorized){
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    var dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    var trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                    var request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    if(weekly){
                        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [UUID().uuidString])
                        dateComp = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
                         trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                         request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    }
                    self.notificationCenter.add(request) { (error) in
                        if(error != nil){
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                }
            }
        }
    }
    
    func deleteTodoItems(todoItem: ToDoModel, completion: CompletionHandler){
        DatabaseHelper.shared.deleteToDoItems(todoModel: todoItem)
        completion(true,Constants.todoDeleteSucess)
    }
    
}


