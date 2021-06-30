//
//  TotalInfo.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//
import Foundation

struct TotalInfo {
    let confirmed: Int?
    let recovered: Int?
    let deaths: Int?
    
    init?(totalInfoData: TotalInfoData) {
        confirmed = totalInfoData.confirmed
        recovered = totalInfoData.recovered
        deaths = totalInfoData.deaths
    }
}
