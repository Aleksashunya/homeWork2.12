//
//  CountryInfo.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 26.06.2021.
//
struct CountryInfoData: Codable, Equatable {
    let country: String
    let code: String
    let confirmed: Int
    let recovered: Int
    let critical: Int
    let deaths: Int
    
    enum Titles: String, CaseIterable {
        case country = "Страна"
        case confirmed = "Подтвержденно случаев"
        case recovered = "Выздоровели"
        case critical = "В критическом состоянии"
        case deaths = "Умерли"
    }
}
