//
//  NetworkCountryInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation
import Alamofire

struct NetworkCountryInfoManager {
    
    static var shared = NetworkCountryInfoManager()
    
    func fetchCountryInfo(country: String, completionHandler: @escaping (CountryInfoData) -> Void) {
        AF.request("\(URLs.countryUrl.rawValue)\(country)", headers: headers as HTTPHeaders) {  urlRequest in
            urlRequest.timeoutInterval = 30.0 }
            .validate()
            .responseDecodable(of: [CountryInfoData].self) { dataResponse in
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
