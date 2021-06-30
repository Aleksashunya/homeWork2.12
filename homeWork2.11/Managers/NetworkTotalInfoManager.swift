//
//  NetworkTotalInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation
import Alamofire

struct NetworkTotalInfoManager {
    var onCompletion: ((TotalInfo) -> Void)?
    
    func fetchTotalInfo() {
        AF.request(URLs.totalUrl.rawValue, headers: headers as HTTPHeaders)
            .validate()
            .responseDecodable(of: [TotalInfoData].self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        guard let totalInfo = TotalInfo(totalInfoData: value[0]) else { return }
                        self.onCompletion!(totalInfo)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
