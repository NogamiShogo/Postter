//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/09.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
