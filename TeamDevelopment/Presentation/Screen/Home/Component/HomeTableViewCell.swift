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
/*protocol CustomCellUpdater {
    func updateTableView()
}*/

protocol CustomCellDelegate {
    func showActionSheet()
    func updateTableView()
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
        
        //goodCount.translatesAutoresizingMaskIntoConstraints = false
        //dateLabel.numberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0
        
        //bodyLabel.adjustsFontSizeToFitWidth = true
        //bodyLabel.minimumScaleFactor = 0.8
        //bodyLabel.adjustsFontSizeToFitWidth = true
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
    //var delegate: CustomCellUpdater?
    var delegate: CustomCellDelegate?
    
    
    // MARK: - Private
    
    
    private func handleTap() {
        self.delegate?.updateTableView()
    }
    
    
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
