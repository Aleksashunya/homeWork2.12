//
//  NetworkTotalInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation
import Alamofire

struct NetworkTotalInfoManager {
    
    static var shared = NetworkTotalInfoManager()
    
    func fetchTotalInfo(completionHandler: @escaping (TotalInfoData) -> Void?) {
        AF.request(URLs.totalUrl.rawValue, headers: headers as HTTPHeaders)
            .validate()
            .responseDecodable(of: [TotalInfoData].self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completionHandler(value[0])
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
