//
//  Tweet.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class TweetViewController: UIViewController, Storyboardable {
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Tweet"

        return viewController
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        
    }
}
