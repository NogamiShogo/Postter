//
//  Item.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

import Foundation

struct Item: Codable {

    let title: String
    let url: URL
    let commentsCount: Int
    let description: String?
    let id: String
    let profileImageUrl: URL
}
