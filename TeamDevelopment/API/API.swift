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
    private let provider: MoyaProvider<MultiTarget>
    
    // 引数にメソッドを定義 @escapingをつける
    func callItem(_ request: ItemRequest, successHandler: @escaping (ItemRequest.Response) -> Void, errorHandler: @escaping (Int) -> Void) {
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
                    print(error)
                    errorHandler(0)
                }
            case .failure(let error):
                print(error)
                errorHandler(0)
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
    
    
    
    // MARK: - Private
    
<<<<<<< HEAD
    
=======
>>>>>>> 8273a9554b58054179957baf5d9e8d75892f5b9e
    private init() {
        provider = MoyaProvider(plugins: [LoggerPlugin()])
    }
}
