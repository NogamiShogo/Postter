//
//  File.swift
//  TeamDevelopment
//
//  Created by shogo nogami on 2019/10/11.
//  Copyright © 2019 shogo nogami. All rights reserved.
//

import PromiseKit
import Moya

// APIを叩く本体 テンプレートです
final class API {
    
    static let shared = API()
    private let provider: MoyaProvider<MultiTarget>
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .iso8601
        //decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()
    
    func call<T: Decodable, Target: TargetType>(_ request: Target) -> Promise<T> {
        let target = MultiTarget(request)
        return Promise { resolver in
            self.provider.request(target) { response in
                switch response.result {
                case .success(let result):
                    do {
                        print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                        resolver.fulfill(try self.decoder.decode(T.self, from: result.data))
                        
                    } catch {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    // 引数にメソッドを定義 @escapingをつける
/*    func callItem(_ request: ItemRequest, successHandler: @escaping (ItemRequest.Response) -> Void, errorHandler: @escaping (Error) -> Void) {
        let target = MultiTarget(request)
        
        print("callItem")
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode((ItemRequest.Response).self, from: result.data))
                } catch {
                    //print(error)
                    print("case: catch")
                    errorHandler(error)
                }
            case .failure(let error):
                //print(error)
                print("case: failure")
                errorHandler(error)
            }
        }
    }
    
    func callUser(_ request: UserRequest, successHandler: @escaping (UserRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        print("callUser")
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode((UserRequest.Response).self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callIsGood(_ request: isGoodRequest, successHandler: @escaping (isGoodRequest.Response) -> Void) {
        let target = MultiTarget(request)
        
        print("callIsGood")
        
        self.provider.request(target) { response in
            switch response.result {
            case .success(let result):
                do {
                    // 結果表示
                    print(try JSONSerialization.jsonObject(with: result.data, options: .allowFragments))
                    
                    // 引数のメソッドを実行
                    successHandler(try JSONDecoder().decode((isGoodRequest.Response).self, from: result.data))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
*/
    
    
    // MARK: - Private
    

    private init() {
        provider = MoyaProvider(plugins: [LoggerPlugin()])
    }
}
