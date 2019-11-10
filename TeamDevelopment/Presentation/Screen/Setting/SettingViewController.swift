//
//  Setting.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class SettingViewController: UITableViewController, Storyboardable {
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Setting"

        return viewController
    }

    // MARK: - Outlet
    
    @IBOutlet weak var AccountID: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AppContext.shared.ID != nil {
            AccountID.text = "\(AppContext.shared.ID!)"
        } else {
            AccountID.text = "未ログイン"
        }
    }
    
    // MARK: - Private
    
    private func setupUI() {
    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        AppContext.shared.ID = nil
        
        let viewController = LoginViewController.build()
        //navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true)
    }
    
}
