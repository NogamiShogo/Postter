//
//  AppUserDefault.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/11/04.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

final class AppContext {
    
    // MARK: - Property
    
    static let shared = AppContext()
    
    private let userDefaults: UserDefaults
    
    var goodBool: [Bool] {
        get {
            return userDefaults.object(forKey: "goodBool") as? [Bool] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "goodBool")
        }
    }
    
    var badBool: [Bool] {
        get {
            return userDefaults.object(forKey: "badBool") as? [Bool] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "badBool")
        }
    }
    
    var ID: Int? {
        get {
            return (userDefaults.object(forKey: "ID") as? Int)
        }
        set {
            userDefaults.set(newValue, forKey: "ID")
        }
    }
    
    // MARK: - Private
    
    private init() {
        userDefaults = UserDefaults.standard
    }
}
