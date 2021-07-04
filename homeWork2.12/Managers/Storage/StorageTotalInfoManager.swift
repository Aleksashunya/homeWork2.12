//
//  TotalInfoStorageManager.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 03.07.2021.
//
import Foundation

class StorageTotalInfoManager {
    
    static let shared = StorageTotalInfoManager()
    
    private var archiveUrl: URL
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private init() {
        archiveUrl = documentDirectory.appendingPathComponent("TotalInfo").appendingPathExtension("plist")
    }
}

extension StorageTotalInfoManager {
    func save(totalInfo: TotalInfoData) {
        DispatchQueue.main.async {
            guard let totalData = try? PropertyListEncoder().encode(totalInfo) else {
                return
            }
            try? totalData.write(to: self.archiveUrl, options: .noFileProtection)
        }
    }
    
    func fetchTotalData() -> TotalInfoData? {
        guard let data = try? Data(contentsOf: archiveUrl) else {
            return nil
        }
        
        guard let totalInfo = try? PropertyListDecoder().decode(TotalInfoData.self, from: data) else {
            return nil
        }
        return totalInfo
    }
}
