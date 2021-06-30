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

