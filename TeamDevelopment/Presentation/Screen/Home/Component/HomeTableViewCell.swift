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
protocol CustomCellUpdater {
    func updateTableView()
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
    
    var delegate: CustomCellUpdater?
    
    // MARK: - Private
    
    func handleTap() {
        self.delegate?.updateTableView()
    }
    
    // MARK: - Action
    
    @IBAction func goodButtonDidTap(sender: UIButton) {
        
        var items: [Item] = []
        var isGood: [Int] = []
        
        let queue = DispatchQueue.global(qos: .default)
        
        /*queue.sync {
            API.shared.callItem(.get, successHandler: { result in
            items = result
            print("itemsget")
                
            
            postId = items[items.count - self.indexPath[1] - 1].No
            
            })
            
            API.shared.callIsGood(.get(userId: AppContext.shared.ID!), successHandler: { result in
                isGood = result
                print("isgoogget")
            })

            for i in 0..<isGood.count {
                if isGood[i] == postId {
                Good = false
                }
            }
            
            print(Good)

            if Good {
                API.shared.callItem(.goodAdd(userId: AppContext.shared.ID!, No: postId), successHandler: { _ in
                    print("addgood")
                    self.handleTap()
                })
            } else {
                API.shared.callItem(.goodDelete(userId: AppContext.shared.ID!, No: postId), successHandler: { _ in
                    print("deletegood")
                    self.handleTap()
                })
            }
                    
            self.handleTap()
                
            
            
        }*/
        queue.sync {
            API.shared.callItem(.get, successHandler: { result in
                items = result
                
                let postId = items[items.count - self.indexPath[1] - 1].No
                
                
                API.shared.callIsGood(.get(userId: AppContext.shared.ID!), successHandler: { result in
                    isGood = result
                    
                    var Good = true
                    
                    for i in 0..<isGood.count {
                        if isGood[i] == postId {
                            Good = false
                        }
                    }
                    print(Good)
                
                    if Good {
                        API.shared.callItem(.goodAdd(userId: AppContext.shared.ID!, No: postId), successHandler: { _ in
                            print("goodadd")
                            self.handleTap()
                        }, errorHandler: { _ in
                            
                        })
                    } else {
                        API.shared.callItem(.goodDelete(userId: AppContext.shared.ID!, No: postId), successHandler: { _ in
                            print("gooddelete")
                            self.handleTap()
                        }, errorHandler: { _ in
                            
                        })
                    }
                })
                //self.handleTap()
            },errorHandler: {_ in
                
            })
        }
    }
    
    
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        
        var items: [Item] = []
         
        API.shared.callItem(.get, successHandler: { result in
            items = result
            print("getItemssuccess")
            
            let userId = items[items.count - self.indexPath[1] - 1].userId
            let postId = items[items.count - self.indexPath[1] - 1].No
            print(userId, postId)
            
            API.shared.callItem(.delete(No: postId, userId: AppContext.shared.ID!), successHandler: { result in
                self.handleTap()
                print("deletesuccess")
            }, errorHandler: { _ in
                print("deletefailed")
            })
        },errorHandler: { _ in
            
        })
    }
}
