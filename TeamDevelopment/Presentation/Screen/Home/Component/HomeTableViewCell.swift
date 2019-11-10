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
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //dateLabel.numberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0
        
        //bodyLabel.adjustsFontSizeToFitWidth = true
        //bodyLabel.minimumScaleFactor = 0.8
        //bodyLabel.adjustsFontSizeToFitWidth = true
        

        // Configure the view for the selected state
    }

    // MARK: - Property

    var model: CardModel! {
        didSet {
            bodyLabel.text = model.body
            dateLabel.text = model.date
            goodCount.text = "\(model.goodCount)"
        }
    }
    
    var indexPath = IndexPath()
    
    // MARK: - Action
    
    @IBAction func goodButtonDidTap(sender: UIButton) {
        
        //let goodBool = AppContext.shared.goodBool
        
        let HV = HomeViewController()
        let postId = HV.items[indexPath[1]].No
        var isGoodBad : [isGoodBad] = []
        
        API.shared.callIsGoodBad(.get(UserID: AppContext.shared.ID!), successHandler: { result in
            isGoodBad = result
        })
        
        if isGoodBad[postId].isGood {
            API.shared.callItem(.goodAdd(postId: postId), successHandler: { _ in
            })
        } else {
            API.shared.callItem(.goodDelete(postId: postId), successHandler: { _ in
            })
        }
        
        print(indexPath[1])
        
    }
    
    @IBAction func badButtonDidTap(_ sender: Any) {
    }
}
