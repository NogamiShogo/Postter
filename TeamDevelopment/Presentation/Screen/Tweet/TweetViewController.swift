//
//  Tweet.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TweetViewController: UIViewController, Storyboardable, UITextFieldDelegate{
    
    // MARK: - Builder

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Tweet"

        return viewController
    }
    
    
    // MARK: - Outlet
    
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    @IBOutlet private weak var textField: UITextField!
    
    
    // MARK: - Proprerty
    
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        textField.rx.text.subscribe(onNext: { text in
            
            if self.textField.text == "" {
                self.tweetButton.isEnabled = false
            } else {
                self.tweetButton.isEnabled = true
            }
            
        }).disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }

    
    // MARK: - Private
    
    
    private func setupUI() {
        
    }
    
    
    // MARK: - Action
    
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if textField.text == "" {
            tweetButton.isEnabled = false
        } else {
            tweetButton.isEnabled = true
        }
    }
    
    @IBAction private func tweetButtonDidTap(_ sender: Any) {
        
        API.shared.callItem(.post(post: textField.text!, userId: AppContext.shared.ID!),successHandler: { result in
            print("tweetsuccess")
        }, errorHandler: { _ in
            print("tweetfaied")
        })
        
        self.dismiss(animated: true)
    }
    
    @IBAction private func cancel(_ sender: Any){
        self.dismiss(animated: true)
    }
}

