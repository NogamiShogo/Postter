//
//  LoggerPlugin.swift
//  TeamDevelopment
//
//  Created by kntk on 2019/12/16.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Moya
import Result

struct LoggerPlugin: PluginType {

    // MARK: - Public

    func willSend(_ request: RequestType, target: TargetType) {
        request.request.map { print($0.curlString) }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print(result.description)
    }
}
