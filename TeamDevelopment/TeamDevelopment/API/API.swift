//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import Foundation

import Moya

// APIを叩く本体 テンプレートです
final class API {
    
    static let shared = API()
    private let provider = MoyaProvider<MultiTarget>()
    
    // 引数にメソッドを定義 @escapingをつける
    func get(_ request: GetItemsRequest, successHandler: @escaping (GetItemsRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(GetItemsRequest.Response.self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func post(_ request: PostRequest, successHandler: @escaping (PostRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(PostRequest.Response.self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private
    
    private init() {}
}

