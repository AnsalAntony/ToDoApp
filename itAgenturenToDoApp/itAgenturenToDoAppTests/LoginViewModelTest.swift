//
//  LoginViewModelTest.swift
//  itAgenturenToDoAppTests
//
//  Created by Ansal Antony on 16/11/22.
//

import Foundation
@testable import itAgenturenToDoApp
import XCTest


class LoginViewModelTest: XCTestCase {
    
    var loginModel: LoginViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loginModel = LoginViewModel()
      
    }
    
    func loginViewModelNotBeNil(){
        
        XCTAssertNotNil(loginModel)
    }
    
    func testValidateEmailPassword(){
        let isValidCredential = loginModel.validateEmailPassword(emai: "eve.holt@reqres.in", passowrd: "eve.holt@reqres.in")
        XCTAssertTrue(isValidCredential.status)
        
    }
    
    func testInvalidEmailPassword(){
        let isInvalidCredential = loginModel.validateEmailPassword(emai: "testEmail@gmail.com", passowrd: "")
        XCTAssertFalse(isInvalidCredential.status)

    }

}
