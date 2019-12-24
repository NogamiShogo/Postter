//
//  UserService.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/12/24.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import PromiseKit

struct UserService {
    func getPassword() -> Promise<[User]> {
        return API.shared.call(UserRequest.getPassWord)
    }
}
