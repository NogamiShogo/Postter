//
//  Home.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit
import PromiseKit

final class HomeViewController: UIViewController, Storyboardable {
    
    // MARK: - Builder
    

    class func build() -> UIViewController {
        let viewController = instantiateViewController()
        viewController.title = "Home"

        return viewController
    }
    
    // MARK: - Proprerty
    
    
    private var items: [Item] = []
    
    private var cards: [CardModel] = [
        CardModel(date: "1900/1/1",
                  body: "dammyData",
                  goodCount: 404,
                  postId: 0)
    ]
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        return refreshControl
    }()
    
    private var nextPage = 1
    private var isLoading = false
    private var itemService: ItemService!

    // MARK: - Outlet
    
    
    @IBOutlet private weak var tweetButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitialItems()
        
        if AppContext.shared.id == nil {
            let viewController = LoginViewController.build()
            present(viewController, animated: true)
        }
    }

    
    // MARK: - Private
    
    
    private func setupUI() {
        self.view.sendSubviewToBack(tableView)
        
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.refreshControl = refreshControl
        
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        tweetButton.imageView?.contentMode = .scaleAspectFit
        tweetButton.contentHorizontalAlignment = .fill
        tweetButton.contentVerticalAlignment = .fill
        tweetButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16);

    }
    
    private func alert() {
        let alert: UIAlertController = UIAlertController(title:"Caution",message:"NetWorkError",preferredStyle: .alert)
        
        let cancel = UIAlertAction(
            title: "cancel",
            style: .default,
            handler: nil
        )
        let retry = UIAlertAction(
            title: "retry",
            style: .default,
            handler: { (UIAlertAction) in
                self.setInitialItems()
            }
        )
        alert.addAction(cancel)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
    
    private func showDeleteActionSheet() {
        // styleをActionSheetに設定
        let alertSheet = UIAlertController(title: "caution", message: "delete this tweet?", preferredStyle: UIAlertController.Style.actionSheet)

            // 自分の選択肢を生成
            /*let action1 = UIAlertAction(title: "1", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
            })*/
            let action2 = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive, handler: {
                (action: UIAlertAction!) in
                self.deleteItem()
            })
            let action3 = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) in
            })

            // アクションを追加.
            //alertSheet.addAction(action1)
            alertSheet.addAction(action2)
            alertSheet.addAction(action3)

            self.present(alertSheet, animated: true, completion: nil)
        
    }
    
    private func escapeShowDeleteActionSheet() {
        let alertSheet = UIAlertController(title: "caution", message: "this tweet is not yours", preferredStyle: UIAlertController.Style.actionSheet)

            // 自分の選択肢を生成
            /*let action1 = UIAlertAction(title: "1", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
            })
            let action2 = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive, handler: {
                (action: UIAlertAction!) in
                self.deleteItem()
            })*/
            let action3 = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) in
            })

            // アクションを追加.
            //alertSheet.addAction(action1)
            //alertSheet.addAction(action2)
            alertSheet.addAction(action3)

            self.present(alertSheet, animated: true, completion: nil)
        
    }
    
    private func deleteItem() {
             
        let indexpath = AppContext.shared.indexpath!
        let userId = items[items.count - indexpath - 1].userId
        let postId = items[items.count - indexpath - 1].No
        print(userId, postId)
         
        itemService.delete(No: postId, userId: userId).done { _ in
            print("deletesuccess")
            self.setInitialItems()
        }.catch { error in
            print(error)
            self.setInitialItems()
        }
        
    }
    
    private func setInitialItems() {
    
        itemService.get()
        
        /*itemService.get().done { items -> Void in
            print("items.count :", items.count)
            print("getItemssuccess")
            
            self.items = items
            self.refreshControl.endRefreshing()
            self.cards = self.cards.filter { $0.body == "" }
            var count = 0
            
            if self.items.count > 20 {
                count = 20
            } else {
                count = self.items.count
            }
            
            for i in (self.items.count - count..<self.items.count).reversed() {
                self.cards.append(CardModel(date: self.items[i].date,
                                            body: self.items[i].post,
                                            goodCount: self.items[i].good,
                                            postId: self.items[i].No))
            }
        }.done { _ in
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }*/
    }
    
    
    
    private func tableViewReloadData() -> Bool {
        tableView.reloadData()
        return true
    }

    private func setMoreItems() {
        var count = 0
        if self.items.count > (nextPage + 1) * 20 {
            count = (nextPage + 1) * 20
        } else {
            count = self.items.count
        }
        let hoge = self.items.count - nextPage * 20
        let fuga = self.items.count - count
        for i in (fuga..<hoge).reversed() {
            self.cards.append(CardModel(date: self.items[i].date, body: self.items[i].post, goodCount: self.items[i].good, postId: self.items[i].No))
        }
        tableView.reloadData()
        nextPage += 1
    }
    
    
    // MARK: - Public
    
    
    func showActionSheet() {
        let indexpath = AppContext.shared.indexpath!
        let userId = items[items.count - indexpath - 1].userId
        //let userId = 1
        print(userId, AppContext.shared.id!)
        if userId == AppContext.shared.id! {
            showDeleteActionSheet()
        } else {
            escapeShowDeleteActionSheet()
        }
    }
    
    func goodButtonDidTap() {
        var isGood: [Int] = []
        let indexpath = AppContext.shared.indexpath!
        let postId = self.items[self.items.count - indexpath - 1].No
                
                
        itemService.getIsGood(userId: AppContext.shared.id!)
        .done { result in
            isGood = result
                var Good = true
                
                for i in 0..<isGood.count {
                    if isGood[i] == postId {
                        Good = false
                    }
                }
                print(Good)
                
                if Good {
                    self.itemService.goodAdd(userId: AppContext.shared.id!, No: postId)
                    .done { _ in
                        print("goodadd")
                        self.setInitialItems()
                            
                    }.catch { error in
                        print(error)
                        self.setInitialItems()
                    }
                } else {
                    self.itemService.goodDelete(userId: AppContext.shared.id!, No: postId)
                    .done { _ in
                        print("gooddelete")
                        self.setInitialItems()
                    }.catch { error in
                        print(error)
                        print("gooddelete")
                        self.setInitialItems()
                    }
                }
        }.catch { error in
            print(error)
        }
    }
    
    
    // MARK: - objc
    
    
    @objc private func didPullToRefresh() {
        setInitialItems()
    }
    
    
    // MARK: - internal
    
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)

        if y > threshold && items.count > nextPage * 20 {
            setMoreItems()
        }
    }
    
    
    // MARK: - Action
    
    
    @IBAction private func reload(_ sender: Any) {
        setInitialItems()
    }
    
    @IBAction private func TweetButtonDidTap(_ sender: Any) {
        let viewController = TweetViewController.build()
        present(viewController, animated: true)
    }
}


// MARK: - UITableViewDataSource


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cards.count
        default:
            fatalError("invaild section")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
            
            cell.indexPath = indexPath
            cell.model = cards[indexPath.row]
            cell.delegate = self as? CustomCellDelegate
            
            return cell
        default:
            fatalError("invaild section")
        }
    }
}
