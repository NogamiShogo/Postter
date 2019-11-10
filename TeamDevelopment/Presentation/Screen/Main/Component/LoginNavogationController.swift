//
//  LoginNavogationController.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/08.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class LoginNavigationController: UINavigationController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = LoginViewController.build()
        setViewControllers([viewController], animated: false)
    }
}
