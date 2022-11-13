//
//  DataDecode.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 13/11/22.
//

import Foundation

extension Data {
    func decodeTo<T: Decodable>(_ type: T.Type) -> T? {
        do {
            let response = try JSONDecoder().decode(type, from: self)
            return response
        } catch let jsonError {
            print("Json Decoding Error",jsonError)
            return nil
        }
    }
}
