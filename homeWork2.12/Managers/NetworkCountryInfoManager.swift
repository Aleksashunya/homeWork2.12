//
//  NetworkCountryInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation
import Alamofire

struct NetworkCountryInfoManager {
    var onCompletion: ((CountryInfoData) -> Void)?
    
    func fetchCountryInfo(country: String) {
        AF.request("\(URLs.countryUrl.rawValue)\(country)", headers: headers as HTTPHeaders)
            .validate()
            .responseDecodable(of: [CountryInfoData].self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        self.onCompletion!(value[0])
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
