//
//  ItemService.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/12/20.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import PromiseKit

struct ItemService {
    
    func get() -> Promise<[Item]> {
        return API.shared.call(ItemRequest.get)
    }
    
    func post(post: String, userId: Int) -> Promise<[VoidModel]> {
        return API.shared.call(ItemRequest.post(post: post, userId: userId))
    }
    
    func delete(No: Int, userId: Int) -> Promise<[VoidModel]> {
        return API.shared.call(ItemRequest.delete(No: No, userId: userId))
    }
    
    func goodAdd(userId: Int, No: Int) -> Promise<[VoidModel]> {
        return API.shared.call(ItemRequest.goodAdd(userId: userId, No: No))
    }
    
    func goodDelete(userId: Int, No: Int) -> Promise<[VoidModel]> {
        return API.shared.call(ItemRequest.goodDelete(userId: userId, No: No))
    }
    
    func getIsGood(userId: Int) -> Promise<[Int]> {
        return API.shared.call(isGoodRequest.get(userId: userId))
    }
}
