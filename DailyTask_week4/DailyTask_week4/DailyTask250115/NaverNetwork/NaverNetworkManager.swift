//
//  NaverNetworkManager.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/16/25.
//

import UIKit

import Alamofire

enum NetworkResult<T> {
    case success(T)
}

class NaverNetworkManager {
    
    static let shared = NaverNetworkManager()
    
    private init() {}
    
    func getNaverShoppingList(url: String,
                              parameters: [String: Any],
                              clientID: String,
                              clientSecret: String,
                              complition: @escaping (NetworkResult<NaverShoppingResponseModel>) -> ()) {
        AF.request(url,method: .get,parameters: parameters,headers: [
                    HTTPHeader(name: "X-Naver-Client-Id", value: clientID),
                    HTTPHeader(name: "X-Naver-Client-Secret",value: clientSecret)
                   ]).responseDecodable(of: NaverShoppingResponseModel.self)
        { response in
            switch response.result {
            case .success(let result):
                print("success")
                complition(.success(result))
            case .failure(let error):
                print("🔥",error)
            }
        }
    }
    
}
