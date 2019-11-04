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

    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var goodCount: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Property

    var model: CardModel! {
        didSet {
            bodyLabel.text = model.body
            dateLabel.text = model.date
        }
    }
    
    // MARK: - Action
    
    @IBAction func goodButtonDidTap(_ sender: Any) {
        let goodBool = AppContext.shared.goodBool
        let items = AppContext.shared.items
        
        if goodBool[0] == true {
            
        } else {
            
        }
        
    }
    
    @IBAction func badButtonDidTap(_ sender: Any) {
    }
}
