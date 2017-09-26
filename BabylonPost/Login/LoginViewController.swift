//
//  LoginViewController.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit

protocol LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol? { get set }
    
    func onLoginError(message: String)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEmailEdited(_ sender: UITextField) {
        btnLogin.isEnabled = !(emailField.text?.isEmpty)!
    }

    @IBAction func onLogin(_ sender: UIButton) {
        presenter?.onLogin(username: emailField.text!)
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func onLoginError(message: String) {
        print(message)
    }
}
