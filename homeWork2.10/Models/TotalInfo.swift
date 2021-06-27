//
//  TotalInfo.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation

struct TotalInfo {
    let confirmed: Int
    let recovered: Int
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
    
    var deathsFormatted: String {
        let formatted = String(describing: formatter.string(for: deaths) ?? "0")
        return formatted
    }
    
    init?(totalInfoData: TotalInfoData) {
        confirmed = totalInfoData.confirmed
        recovered = totalInfoData.recovered
        deaths = totalInfoData.deaths
    }
}
