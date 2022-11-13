//
//  LoginViewModel.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 13/11/22.
//

import Foundation



final class LoginViewModel {
    
    typealias CompletionHandler = (_ success:Bool, _ message: String) -> Void
    
    func validateEmailPassword(emai: String, passowrd: String) -> (status: Bool, message: String){
        if(emai == ""){
            return(false, Constants.checkEmaiAddress)
            
        }
        
        let emailValied = Formaters.shared.isValidEmail(email: emai)
        
        if(!emailValied){
            return(false, Constants.emaiValidation)
        }
        if(passowrd == ""){
            
            return(false, Constants.checkPassword)
        }
        return (true , "")
    }
    
    func loginApp(emai: String, passowrd: String, completion: @escaping CompletionHandler){
        
        ToDoAppApiService.sharedInstance.login(email: emai, password: passowrd) { responce, error in
            if error == nil {
                if(responce?.token != "" && responce?.token != nil){
                    completion(true, "")
                }else{
                    completion(false, Constants.someThingWentWrong)
                }
            } else {
                completion(false, error?.localizedDescription ?? "")
            }
        }
        
    }
    
}
