//
//  NetworkTotalInfoManager.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation

struct NetworkTotalInfoManager {
    var onCompletion: ((TotalInfo) -> Void)?
    
    func fetchTotalInfo() {
        let request = NSMutableURLRequest(url: NSURL(string: totalUrl)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request as URLRequest) { data, _, _ in
            if let data = data {
                if let totalInfo = self.parseJSON(withData: data) {
                    self.onCompletion?(totalInfo)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> TotalInfo? {
        let decoder = JSONDecoder()
        
        do {
            let totalInfoDatas = try decoder.decode([TotalInfoData].self, from: data)
            guard !totalInfoDatas.isEmpty else { return nil }
            let totalInfoData = totalInfoDatas[0]
            
            guard let totalInfo = TotalInfo(totalInfoData: totalInfoData) else { return nil }
            return totalInfo
        
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
