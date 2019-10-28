//
//  PostRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/23.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

struct PostRequest {
    let body: String?
}

// MARK: - APITargetType

extension PostRequest: APITargetType {

    typealias Response = [Item]

    var path: String {
        return "/postter"
    }

    var method: Method {
        return .post
    }

    var task: Task {
        return .requestParameters(parameters: ["body": body!], encoding: JSONEncoding.default)
    }
}
