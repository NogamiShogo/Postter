//
//  GoodBadRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/10.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

enum isGoodRequest {
    case get(userId: Int)
}

extension isGoodRequest: BaseTargetType {
    typealias Response = [Int]
    
    var path: String {
        switch self {
        case .get:
            return "/good"
        }
    }
    
    var method: Method {
        switch self {
        case .get:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .get(let userId):
            let parameters: Parameters = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    
    
}

