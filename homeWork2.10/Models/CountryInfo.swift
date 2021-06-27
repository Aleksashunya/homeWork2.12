//
//  CountryInfo.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation

struct CountryInfo {
    let country: String
    let code: String
    let confirmed: Int
    let recovered: Int
    let critical: Int
    let deaths: Int
    
    var formatter: NumberFormatter {
        let format = NumberFormatter()
        
        format.numberStyle = .decimal
        format.groupingSeparator = " "
        return format
    }
    
    var confirmedFormatted: String {
        let formatted = String(describing: formatter.string(for: confirmed) ?? "0")
        return formatted
    }
    
    var recoveredFormatted: String {
        let formatted = String(describing: formatter.string(for: recovered) ?? "0")
        return formatted
    }
    
    var criticalFormatted: String {
        let formatted = String(describing: formatter.string(for: critical) ?? "0")
        return formatted
    }
    
    var deathsFormatted: String {
        let formatted = String(describing: formatter.string(for: deaths) ?? "0")
        return formatted
    }
    
    init?(countryInfoData: CountryInfoData) {
        country = countryInfoData.country
        code = countryInfoData.code
        confirmed = countryInfoData.confirmed
        recovered = countryInfoData.recovered
        critical = countryInfoData.critical
        deaths = countryInfoData.deaths
    }
    
    enum Titles: String, CaseIterable {
        case country = "Страна"
        case confirmed = "Подтвержденно случаев"
        case recovered = "Выздоровели"
        case critical = "В критическом состоянии"
        case deaths = "Умерли"
    }
}

