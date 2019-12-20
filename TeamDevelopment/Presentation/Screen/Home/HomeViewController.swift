//
//  Home.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

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
        setInitialItems(complete: {
            print("reloaddata")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        if AppContext.shared.id == nil {
            let viewController = LoginViewController.build()
            present(viewController, animated: true)
        }
    }

    // MARK: - Private
    
    private func setupUI() {
        self.view.sendSubviewToBack(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        //tableView.separatorStyle = .none
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
                self.setInitialItems(complete: {
                    print("reloaddata")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        )
        alert.addAction(cancel)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let indexpath = AppContext.shared.indexpath!
        let userId = items[items.count - indexpath - 1].userId
        //let userId = 1
        print(userId, AppContext.shared.id!)
        if userId == AppContext.shared.id! {
            showDeleteActionSheet()
        } else {
            hoge()
        }
    }
    
    func showDeleteActionSheet() {
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
    
    func hoge() {
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
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)

        if y > threshold && items.count > nextPage * 20 {
            setMoreItems()
        }
    }
    
    @objc private func didPullToRefresh() {
        setInitialItems(complete: {
            print("reloaddata")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
    
    
    // MARK: - setItems
    
    
    private func setInitialItems( complete: @escaping () -> Void) {
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async { [unowned self] in
            API.shared.callItem(.get, successHandler: { items in
                print("items.count :", items.count)
                self.items = items
                self.refreshControl.endRefreshing()
                
                print("getItemssuccess")
                
                self.cards = self.cards.filter { $0.body == "" }
                
                var count = 0
                if self.items.count > 20 {
                    count = 20
                } else {
                    count = self.items.count
                }
                
                for i in (self.items.count - count..<self.items.count).reversed() {
                    self.cards.append(CardModel(date: self.items[i].date, body: self.items[i].post, goodCount: self.items[i].good, postId: self.items[i].No))
                }
                
                complete()
            }, errorHandler: { error in
                self.alert()
                print("getItemfailed")
                print(error)
                self.refreshControl.endRefreshing()
            })
        }
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
    
    func goodButtonDidTap() {
        var isGood: [Int] = []
        
        //let queue = DispatchQueue.global(qos: .default)
        
        let indexpath = AppContext.shared.indexpath!
        
        
        //queue.sync {
        let postId = self.items[self.items.count - indexpath - 1].No
                
                
            API.shared.callIsGood(.get(userId: AppContext.shared.id!), successHandler: { result in
                isGood = result
                
                var Good = true
                
                for i in 0..<isGood.count {
                    if isGood[i] == postId {
                        Good = false
                    }
                }
                print(Good)
                
                if Good {
                    API.shared.callItem(.goodAdd(userId: AppContext.shared.id!, No: postId), successHandler: { _ in
                        print("goodadd")
                        self.setInitialItems(complete: {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        })
                    }, errorHandler: { _ in
                        self.setInitialItems(complete: {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        })
                    })
                } else {
                    API.shared.callItem(.goodDelete(userId: AppContext.shared.id!, No: postId), successHandler: { _ in
                        print("gooddelete")
                        self.setInitialItems(complete: {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        })
                            
                        }, errorHandler: { _ in
                        self.setInitialItems(complete: {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        })
                    })
                }
            })
        //}
    }
        
                
        
    
    private func deleteItem() {
             
        let indexpath = AppContext.shared.indexpath!
         
         //let userId = items[items.count - indexPath! - 1].userId
        let postId = items[items.count - indexpath - 1].No

        let userId = AppContext.shared.id!
        print(userId, postId)
         
        API.shared.callItem(.delete(No: postId, userId: userId), successHandler: { result in
            print("deletesuccess")
            self.setInitialItems(complete: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }, errorHandler: { error in
            print(error)
            self.setInitialItems(complete: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        })
    }
    
    
    // MARK: - Action
    
    
    @IBAction private func reload(_ sender: Any) {
        setInitialItems(complete: { [unowned self] in
            DispatchQueue.main.async {
                print("reloaddata")
                self.tableView.reloadData()
            }
        })
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
            // 2.tableViewから登録したnibのCellクラスを取り出す
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
            
            cell.indexPath = indexPath
            cell.model = cards[indexPath.row]
            cell.delegate = self
            
            // 3.このif文を書いてHomeTableViewCellであることを保証し、
            // インスタンス変数modelにアクセスする
            // このas?は「ダウンキャスト」を行なっている
            /*if let cell = cell as? HomeTableViewCell {
                cell.model = cards[indexPath.row]
            }*/
            

            // 4.returnする
            return cell
        default:
            fatalError("invaild section")
        }
    }
}

extension HomeViewController: UITableViewDelegate, CustomCellDelegate {
    func updateTableView() {
        setInitialItems(complete: {
            print("reloaddata")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}
