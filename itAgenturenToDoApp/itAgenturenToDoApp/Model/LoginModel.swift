//
//  LoginModel.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 13/11/22.
//

import Foundation

struct LoginModel: Codable {
    
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case token
    }
    
}

