//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

import UIKit

// Storyboard - ViewControllerクラスの関係と
// xib - 〇〇Cellクラスの関係は同じ
// UIViewControllerではなく〇〇Cellを継承させること
final class HomeTableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet private weak var dayLabel: UILabel!

    // MARK: - Property

    var model: CardModel! {
        didSet {
            mainTextLabel.text = model.text
            dayLabel.text = model.day
        }
    }
    
    // MARK: - Action
    
    @IBAction func goodButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func badButtonDidTap(_ sender: Any) {
    }
}