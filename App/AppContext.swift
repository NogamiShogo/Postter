//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/31.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

final class AppContext {
    
    // MARK: - Property
    
    static let shared = AppContext()
    
    private let userDefaults: UserDefaults
    
    var goodBool: [Int:Bool] {
        get {
            return userDefaults.object(forKey: "goodBool") as? [Int:Bool] ?? [:]
        }
        set {
            userDefaults.set(newValue, forKey: "goodBool")
        }
    }
    
    // MARK: - Private
    
    private init() {
        userDefaults = UserDefaults.standard
    }
}
