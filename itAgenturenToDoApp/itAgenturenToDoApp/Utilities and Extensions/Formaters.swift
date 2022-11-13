//
//  Formaters.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 12/11/22.
//

import Foundation


class Formaters {
    
    static let shared = Formaters()
    
    public func formateDateTime(dateTime: Date, formate: String) -> String {
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = formate
        let stringFromDate: String = dateFormater.string(from: dateTime) as String
        return stringFromDate
        
    }
    
    public func convertDateStringToDate(dateValue: String, formate: String)-> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: dateValue)
        if(date != nil){
            return date ?? Date()
        }
        return Date()
    }
    
    public func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}



