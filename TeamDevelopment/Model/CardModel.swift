//
//  CardModel.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation
import UIKit

struct CardModel {

    // Optional型 nil(null)を入れることが可能
    // Swiftの変数は通常はnilが入らない。?をつけることで
    // nilを入れることが可能, imageを「値を入れても入れなくても良い」
    // と言うOptionにすることができる
    let date: String
    let body: String
    let goodCount: Int
    let postId: Int
}
