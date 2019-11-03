//
//  storyboardable.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import UIKit

protocol Storyboardable: class {
    associatedtype Instance
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func instantiateViewController() -> Instance
}

extension Storyboardable where Self: UIViewController {

    static var storyboardName: String {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }

    static func instantiateViewController() -> Self {
        return storyboard.instantiateInitialViewController() as! Self
    }
}
