//
//  LoginViewController.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/08.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController, Storyboardable {
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Login"

        return viewController
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Proprerty
    
    var Users: [User] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getPassword()
        
        idTextField.rx.text.subscribe(onNext: { text in
            
            if self.idTextField.text != "" && self.passwordTextField.text != "" {
                self.loginButton.isEnabled = true
            } else {
                self.loginButton.isEnabled = false
            }
            
        }).disposed(by: disposeBag)
        
        passwordTextField.rx.text.subscribe(onNext: { text in
            
            if self.idTextField.text != "" && self.passwordTextField.text != "" {
                self.loginButton.isEnabled = true
            } else {
                self.loginButton.isEnabled = false
            }
            
        }).disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        idTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    private func getPassword() {
        API.shared.callUser(.getPassWord, successHandler: { result in
            self.Users = result
        })
    }
    
    // MARK: - Action
    
    @IBAction func button(_ sender: Any) {
        
        var accountId = 0
        var index = 0
        
        for i in 1...10 {
            if idTextField.text == "\(i)" {
                accountId = i
            }
        }
        
        for i in 0..<Users.count {
            if accountId == Users[i].userId {
                index = i
            }
        }
        
        
        
        if passwordTextField.text == Users[index].pass {
            AppContext.shared.ID = accountId
            idTextField.text = ""
            passwordTextField.text = ""
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func initialLoginButton(_ sender: Any) {
        AppContext.shared.ID = 1
        self.dismiss(animated: true)
    }
    
}

