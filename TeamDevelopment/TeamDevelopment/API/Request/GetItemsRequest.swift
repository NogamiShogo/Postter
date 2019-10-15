//
//  .swift.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

struct GetItemsRequest {

    let page: Int
    let query: String?
}

// MARK: - APITargetType

extension GetItemsRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/items"
    }

    var method: Method {
        return .get
    }

    var task: Task {
        // 検索機能を使って初期値をSwiftの記事限定にしておいた
        return .requestParameters(parameters: ["page": page, "query": query ?? "swift"], encoding: URLEncoding.default)
    }
}

