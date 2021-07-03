//
//  GetFlag.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 04.07.2021.
//

import Foundation

struct GetFlag {
    
    func getFlag(from countryCode: String) -> String {
        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
