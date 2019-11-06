//
//  GoodAdd.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/04.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

struct GoodAddRequest {
    let postId: Int
}

struct GoodDeleteRequest {
    let postId: Int
}

// MARK: - APITargetType

extension GoodAddRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/good/1"
    }

    var method: Method {
        return .put
    }

    var task: Task {
        return .requestParameters(parameters: ["postId": postId], encoding: JSONEncoding.default)
    }
}

extension GoodDeleteRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/good/5"
    }

    var method: Method {
        return .delete
    }

    var task: Task {
        return .requestParameters(parameters: ["postId": postId], encoding: JSONEncoding.default)
    }
}



