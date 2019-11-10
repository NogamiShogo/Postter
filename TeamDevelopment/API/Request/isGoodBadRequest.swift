//
//  GoodBadRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/10.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

enum isGoodBadRequest {
    case get(UserID: Int)
}

extension isGoodBadRequest: BaseTargetType {
    typealias Response = [isGoodBad]
    
    var path: String {
        switch self {
        case .get:
            return ""
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
        case .get(let UserID):
            let parameters: Parameters = [
                "UserID": UserID
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    
    
}

