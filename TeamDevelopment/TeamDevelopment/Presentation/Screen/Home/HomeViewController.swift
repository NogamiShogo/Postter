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
    
    private var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var cards: [CardModel] = []

    // MARK: - Outlet
    
    @IBOutlet private weak var tweetButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setItems()
         }

    
    // MARK: - Private
    
    private func setupUI() {
        self.view.sendSubviewToBack(tableView)
        
        tableView.dataSource = self
        tableView.allowsSelection = false
        //tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        tweetButton.imageView?.contentMode = .scaleAspectFit
        tweetButton.contentHorizontalAlignment = .fill
        tweetButton.contentVerticalAlignment = .fill
        tweetButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16);

    }
    
    private func setItems() {
        cards = cards.filter { $0.body == "" }

        API.shared.get(GetItemsRequest(page: 1), successHandler: { result in
            self.items = result
            
            for i in (0..<self.items.count).reversed() {
                self.cards.append(CardModel(date: self.items[i].date, body: self.items[i].post))
            }
            
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Action
    
    @IBAction func reload(_ sender: Any) {
        setItems()
    }
    
    @IBAction func TweetButtonDidTap(_ sender: Any) {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
            // 3.このif文を書いてHomeTableViewCellであることを保証し、
            // インスタンス変数modelにアクセスする
            // このas?は「ダウンキャスト」を行なっている
            if let cell = cell as? HomeTableViewCell {
                cell.model = cards[indexPath.row]
            }
            
            
            
            // 4.returnする
            return cell
        default:
            fatalError("invaild section")
        }
    }
}
