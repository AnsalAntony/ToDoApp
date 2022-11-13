//
//  ToDoAppApi.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 13/11/22.
//

import Foundation


final class ToDoAppApiService {
    static let sharedInstance = ToDoAppApiService()
    
    private init() {}
    
    func login(email: String, password: String, with completion: @escaping (LoginModel?, Error?) -> Void) {
        let urlString = APIConstants.baseUrl + APIConstants.Endpoints.login
        let parameters = ["email": email, "password": password]
        let url = URL(string: urlString)!
        
        let session = URLSession.shared
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            let response = data.decodeTo(LoginModel.self)
            completion(response, nil)
        })
        
        task.resume()
    }
    
}
