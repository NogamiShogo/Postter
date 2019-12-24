//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellDelegate {
    func showActionSheet()
    func goodButtonDidTap()
}

final class HomeTableViewCell: UITableViewCell {

    
    // MARK: - Outlet
    

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var goodCount: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet weak var goodButton: UIButton!
    
    
    // MARK: - Lifecycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0
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
    var delegate: CustomCellDelegate?
    
    
    // MARK: - Private
    
    
    
    // MARK: - Action
    
    
    @IBAction func goodButtonDidTap(sender: UIButton) {
        AppContext.shared.indexpath = indexPath[1]
        
        if let delegate = self.delegate {
            delegate.goodButtonDidTap()
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        AppContext.shared.indexpath = indexPath[1]
        
        if let delegate = self.delegate {
            delegate.showActionSheet()
        }
    }
}
