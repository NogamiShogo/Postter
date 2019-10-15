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
    
    private let cards = [
        CardModel(day: "2019/10/11", text: "テスト")
    ]

    // MARK: - Outlet
    
    @IBOutlet private weak var tweetButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        self.view.sendSubviewToBack(tableView)
        
        tableView.dataSource = self
        //tableView.allowsSelection = false
        //tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")

    }
    
    // MARK: - Action
    
    @IBAction func TweetButtonDidTap(_ sender: Any) {
        let viewController = TweetViewController.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

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
            /*if let cell = cell as? HomeTableViewCell {
                cell.model = cards[indexPath.row]
            }*/
            
            let bell = cell as? HomeTableViewCell
            bell?.model = cards[indexPath.row]

            // 4.returnする
            return cell
        default:
            fatalError("invaild section")
        }
    }
}
