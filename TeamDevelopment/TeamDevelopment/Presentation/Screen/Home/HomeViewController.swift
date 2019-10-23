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
    
    private let cards = [
        CardModel(day: "date", text: "body"),
        
        CardModel(day: items[0].date, text: items[0].post)
    ]

    // MARK: - Outlet
    
    @IBOutlet private weak var tweetButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setupUI()
        
    }
    
    // MARK: - Private
    
    private func setupUI() {
        self.view.sendSubviewToBack(tableView)
        
        tableView.dataSource = self
        tableView.allowsSelection = false
        //tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
    }
    
    
    
    private func setItems() {
        API.shared.call(GetItemsRequest(page: 1, query: ""), successHandler: { result in
            self.items = result
            
            
        })
    }
    
    // MARK: - Action
    
    @IBAction func reload(_ sender: Any) {
        setItems()
    }
    
    @IBAction func TweetButtonDidTap(_ sender: Any) {
        let viewController = TweetViewController.build()
        navigationController?.pushViewController(viewController, animated: true)
        
        print(items[0].post)
        print(items[1].post)
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
