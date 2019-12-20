//
//  UITableView+.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/12/16.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

extension UITableView {
    
    func startFooterLoading() {
        let indicatorView = UIActivityIndicatorView(style: .white)
        indicatorView.color = .gray
        indicatorView.backgroundColor = .clear
        indicatorView.frame.size.height = 50
        indicatorView.isHidden = false
        self.tableFooterView = indicatorView
    }

    func stopFooterLoading() {
        self.tableFooterView = nil
    }
}
