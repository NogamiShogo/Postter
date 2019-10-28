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
    //let query: String?
}

// MARK: - APITargetType

extension GetItemsRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/postter"
    }

    var method: Method {
        return .get
    }

    var task: Task {
        return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
    }
}

