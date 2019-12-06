//
//  UserRequest.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/10.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya

enum UserRequest {
        case getPassWord
}

extension UserRequest: BaseTargetType {
    typealias Response = [User]
    
    var path: String {
        switch self {
        case .getPassWord:
            return "/user"
        }
    }
    
    var method: Method {
        switch self {
        case .getPassWord:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPassWord:
            return .requestPlain
        }
    }
    
    
    
}
