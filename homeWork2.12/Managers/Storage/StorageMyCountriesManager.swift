//
//  StorageMyCountriesManager.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 03.07.2021.
//
import Foundation

class StorageMyCountriesManager {
    
    static let shared = StorageMyCountriesManager()
    
    private var archiveUrl: URL
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private init() {
        archiveUrl = documentDirectory.appendingPathComponent("MyCountriesInfo").appendingPathExtension("plist")
    }
}

extension StorageMyCountriesManager {
    
    func saveNewCountry(countryInfo: CountryInfoData) {
        var countriesInfo = fetchCountryInfo()
        let repeatingIndicator = countriesInfo.filter { $0.country == countryInfo.country }
        
        guard  repeatingIndicator.isEmpty else { return }
        
        countriesInfo.append(countryInfo)
        DispatchQueue.main.async {
            guard let countryData = try? PropertyListEncoder().encode(countriesInfo) else { return }
            try? countryData.write(to: self.archiveUrl, options: .noFileProtection)
        }
    }
    
    func deleteCountry(_ section: Int) {
        var countriesInfo = fetchCountryInfo()
        
        countriesInfo.remove(at: section)
        
        guard let countryData = try? PropertyListEncoder().encode(countriesInfo) else { return }
        try? countryData.write(to: self.archiveUrl, options: .noFileProtection)
    }
    
    func updateCountriesInfo() {
        var countriesInfo = fetchCountryInfo()
        
        for index in 0..<countriesInfo.count {
            NetworkCountryInfoManager.shared.fetchCountryInfo(country: countriesInfo[index].country) { countryInfo in
                countriesInfo[index] = countryInfo
            }
        }
        
        guard let countriesData = try? PropertyListEncoder().encode(countriesInfo) else { return }
        try? countriesData.write(to: archiveUrl, options: .noFileProtection)
    }
    
    
    func getNewData() -> [CountryInfoData] {
        var countriesInfo = fetchCountryInfo()
        
        for index in 0..<countriesInfo.count {
            NetworkCountryInfoManager.shared.fetchCountryInfo(country: countriesInfo[index].country) { countryInfo in
                countriesInfo[index] = countryInfo
            }
        }
        return countriesInfo
    }
    
    func fetchCountryInfo() -> [CountryInfoData] {
        guard let data = try? Data(contentsOf: archiveUrl) else { return [] }
        
        guard let countryInfo = try? PropertyListDecoder().decode([CountryInfoData].self, from: data) else {
            return []
        }
        return countryInfo
    }
}
