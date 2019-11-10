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
    case post (post: String)
    case goodAdd (postId: Int)
    case goodDelete (postId: Int)
    case badAdd (postId: Int)
    case badDelete (postId: Int)
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
        case .goodAdd:
            return "/good"
        case .goodDelete:
            return "/good"
        case .badAdd:
            return "/bad"
        case .badDelete:
            return "/bad"
        }
    }

    var method: Method {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .goodAdd:
            return .put
        case .goodDelete:
            return .delete
        case .badAdd:
            return .put
        case .badDelete:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .get:
            return .requestPlain
        case .post(let post):
            let parameters: Parameters = [
                "post": post
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .goodAdd(let postId):
            let parameters: Parameters = [
                "postId": postId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .goodDelete(let postId):
            let parameters: Parameters = [
                "postId": postId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .badAdd(let postId):
            let parameters: Parameters = [
                "postId": postId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .badDelete(let postId):
            let parameters: Parameters = [
                "postId": postId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}

        
