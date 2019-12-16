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
        CardModel(date: "",
                  body: "dammyData",
                  goodCount: 404,
                  postId: 0)
    ]

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
        setItems(complete: {
            DispatchQueue.main.async {
                print("reloaddata")
                self.tableView.reloadData()
            }
        })
        
        if AppContext.shared.ID == nil {
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
                self.setItems {
                    DispatchQueue.main.async {
                        print("reloaddata")
                        self.tableView.reloadData()
                    }
                }
            }
        )
        alert.addAction(cancel)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
    
    private func setItems ( complete: @escaping () -> Void) {
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async { [unowned self] in
            API.shared.callItem(.get, successHandler: { result in
            
                self.items = result
                
                print("getItemssuccess")
                
                self.cards = self.cards.filter { $0.body == "" }
                
                for i in (0..<self.items.count).reversed() {
                    self.cards.append(CardModel(date: self.items[i].date, body: self.items[i].post, goodCount: self.items[i].good, postId: self.items[i].No))
                }
                DispatchQueue.main.async {
                    complete()
                    print("abc")
                }
            }, errorHandler: {_ in
                self.alert()
                print("getItemfailed")
            })
        }
        
        print("setItems")
    }
    

    
    // MARK: - Action
    
    @IBAction private func reload(_ sender: Any) {
        setItems(complete: { [unowned self] in
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

extension HomeViewController: UITableViewDelegate, CustomCellUpdater {
    func updateTableView() {
        setItems(complete: {
            DispatchQueue.main.async {
                print("reloaddata")
                self.tableView.reloadData()
            }
        })
    }
}
