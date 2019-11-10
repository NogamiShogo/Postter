//
//  APITargetTipe.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {
    associatedtype Response: Codable
}

extension BaseTargetType {

    var baseURL: URL {
        return URL(string: AppConstant.baseURL)!
    }

    var headers: [String: String]? {
        return [:]
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}

typealias Parameters = [String: Any]
