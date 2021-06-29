//
//  NetworkCountryInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation

struct NetworkCountryInfoManager {
    var onCompletion: ((CountryInfo) -> Void)?
    
    func fetchCountryInfo(country: String) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(countryUrl)\(country)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request as URLRequest) { data, _, _ in
            if let data = data {
                if let countryInfo = self.parseJSON(withData: data) {
                    self.onCompletion?(countryInfo)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CountryInfo? {
        let decoder = JSONDecoder()
        
        do {
            let countryInfoDatas = try decoder.decode([CountryInfoData].self, from: data)
            guard !countryInfoDatas.isEmpty else { return nil }
            let countryInfoData = countryInfoDatas[0]
            
            guard let countryInfo = CountryInfo(countryInfoData: countryInfoData) else { return nil }
            return countryInfo
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
