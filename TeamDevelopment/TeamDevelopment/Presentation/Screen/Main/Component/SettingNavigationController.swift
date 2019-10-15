//
//  SettingNavigationController.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class SettingNavigationController: UINavigationController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = SettingViewController.build()
        setViewControllers([viewController], animated: false)
    }
}
