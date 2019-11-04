//
//  PostRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/23.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

struct PostRequest {
    let post: String
}

// MARK: - APITargetType

extension PostRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return ""
    }

    var method: Method {
        return .post
    }

    var task: Task {
        return .requestParameters(parameters: ["post": post], encoding: JSONEncoding.default)
    }
}
