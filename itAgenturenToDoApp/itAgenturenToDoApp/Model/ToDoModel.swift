//
//  ToDoModel.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import Foundation
import RealmSwift

class ToDoModel: Object {
    
    @Persisted var title: String?
    @Persisted var toDoDescription: String?
    @Persisted @objc var time: String?
    @Persisted @objc var date: String?
    @Persisted @objc var daily = Bool()
    @Persisted @objc var weekly = Bool()
    @Persisted @objc var alaram = Bool()
    
    convenience init(title: String,toDoDescription: String,time: String, date: String,daily: Bool, weekly:Bool, alaram: Bool){
        self.init()
        self.title = title
        self.toDoDescription = toDoDescription
        self.time = time
        self.date = date
        self.daily = daily
        self.weekly = weekly
        self.alaram = alaram
    }
    
}
