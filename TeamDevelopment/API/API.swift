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
                    //print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    print("postSuccess")
                    
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
    
    func goodAdd(_ request: GoodAddRequest, successHandler: @escaping (GoodAddRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    //print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    print("goodAddSuccess")
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(GoodAddRequest.Response.self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func goodDelete(_ request: GoodDeleteRequest, successHandler: @escaping (GoodDeleteRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    //print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    print("goodDeleteSuccess")
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(GoodDeleteRequest.Response.self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func badAdd(_ request: BadAddRequest, successHandler: @escaping (BadAddRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    //print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    print("badAddSuccess")
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(BadAddRequest.Response.self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func badDelete(_ request: BadDeleteRequest, successHandler: @escaping (BadDeleteRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    //print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    print("badDeleteSuccess")
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode(BadDeleteRequest.Response.self, from: result.data))
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
