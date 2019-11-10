//
//  LoginViewController.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/08.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, Storyboardable {
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Login"

        return viewController
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var IDTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    // MARK: - Proprerty
    
    var Users: [User] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        IDTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    private func getPassword() {
        API.shared.callIsGoodBad(.getIsGood(UserID: AppContext.shared.ID!), successHandler: { result in
            self.Users = result
            })
    }
    
    // MARK: - Action
    
    @IBAction func button(_ sender: Any) {
        for i in 1...10 {
            if IDTextField.text == "\(i)" {
                AppContext.shared.ID = i
            }
        }
        
        IDTextField.text = ""
        
        if PasswordTextField.text == Users[AppContext.shared.ID!].password {
            self.dismiss(animated: true)
        }
    }
    
    
}

