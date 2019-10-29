//
//  Tweet.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

final class TweetViewController: UIViewController, Storyboardable, UITextFieldDelegate{
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Tweet"

        return viewController
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    // MARK: - Proprerty
    
    @IBOutlet private weak var textField: UITextField!
    
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

    
    private func textFieldDidEndEditing(textField: UITextField) {
        tweetButton.isEnabled = true
    }
    
    // MARK: - Private
    
    private func setupUI() {
        tweetButton.isEnabled = false
    }
    
    // MARK: - Action
    
    @IBAction private func tweetButtonDidTap(_ sender: Any) {
        
        if textField.text != "" {
            API.shared.post(PostRequest(name: textField.text), successHandler: { result in
            })
            textField.text = ""
        }
        
        
        
        self.dismiss(animated: true)
    }
    
    @IBAction private func cancel(_ sender: Any){
        self.dismiss(animated: true)
    }
}

