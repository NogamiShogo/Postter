//
//  GoodDelete.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/04.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

struct BadAddRequest {
    let postId: Int
}

struct BadDeleteRequest {
    let postId: Int
}

// MARK: - APITargetType

extension BadAddRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/badAdd"
    }

    var method: Method {
        return .put
    }

    var task: Task {
        return .requestParameters(parameters: ["postId": postId], encoding: JSONEncoding.default)
    }
}

extension BadDeleteRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/badDelete"
    }

    var method: Method {
        return .put
    }

    var task: Task {
        return .requestParameters(parameters: ["postId": postId], encoding: JSONEncoding.default)
    }
}

