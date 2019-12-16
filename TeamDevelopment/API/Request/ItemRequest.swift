//
//  ItemsRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/10.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

enum ItemRequest {
    case get
    case post (post: String, userId: Int)
    case delete (No: Int, userId: Int)
    case goodAdd (userId: Int, No: Int)
    case goodDelete (userId: Int, No: Int)
}


// MARK: - APITargetType


extension ItemRequest: BaseTargetType {

    typealias Response = [Item]

    var path: String {
        switch self {
        case .get:
            return ""
        case .post:
            return ""
        case .delete:
            return "/del"
        case .goodAdd:
            return "/good"
        case .goodDelete:
            return "/gooddel"
        }
    }

    var method: Method {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .post
        case .goodAdd:
            return .put
        case .goodDelete:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .get:
            return .requestPlain
        case .post(let post, let userId):
            let parameters: Parameters = [
                "post": post,
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .delete(let userId, let No):
            let parameters: Parameters = [
                "No": No,
                "userID": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .goodAdd(let userId, let No):
            let parameters: Parameters = [
                "userId": userId,
                "No": No
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .goodDelete(let userId, let No):
            let parameters: Parameters = [
                "userId": userId,
                "No": No
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}

        
