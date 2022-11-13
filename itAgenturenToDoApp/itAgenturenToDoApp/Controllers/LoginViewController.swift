//
//  LoginViewController.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 09/11/22.
//

import UIKit
import TPKeyboardAvoidingSwift

final class LoginViewController: UIViewController {
    
    @IBOutlet weak private var loginMainView: UIView!
    @IBOutlet weak private var emailView: UIView!
    @IBOutlet weak private var passwordView: UIView!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpUi(){
        
        loginMainView.layer.cornerRadius = 7
        loginMainView.layer.masksToBounds = true
        emailView.layer.borderColor = UIColor.lightGray.cgColor
        let borderWidth = 0.5
        emailView.layer.borderWidth = borderWidth
        let cornerRadius: CGFloat = 5
        emailView.layer.cornerRadius = cornerRadius
        emailView.layer.masksToBounds = true
        passwordView.layer.borderColor = UIColor.lightGray.cgColor
        passwordView.layer.borderWidth = borderWidth
        passwordView.layer.cornerRadius = cornerRadius
        passwordView.layer.masksToBounds = true
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
        loginButton.layer.borderWidth = borderWidth
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.layer.masksToBounds = true
        loginMainView.setBackgroundShadow(setColor: UIColor.lightGray)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        let value = loginViewModel.validateEmailPassword(emai: emailTextField.text ?? "", passowrd: passwordTextField.text ?? "")
        
        if(!value.status && value.message != ""){
            alertPresent(title: "", message: value.message)
        }else{
            // Api calling
            ProgressiveLoader.sharedInstance.showLoader(target: self, title: Constants.pleaseWaitLoader)
            loginViewModel.loginApp(emai: emailTextField.text ?? "", passowrd: passwordTextField.text ?? "") {[weak self] success, message  in
                if success {
                    DispatchQueue.main.async {
                        ProgressiveLoader.sharedInstance.dismissLoader(target: self!)
                        let homeViewController = HomeViewController.make()
                        guard let navigationController = self?.navigationController else { return }
                        navigationController.setViewControllers([homeViewController], animated: false)
                    }
                }else{
                    DispatchQueue.main.async {
                        ProgressiveLoader.sharedInstance.dismissLoader(target: self!)
                        self?.alertPresent(title: "", message: message)
                    }
                }
            }
        }
    }
    
}
