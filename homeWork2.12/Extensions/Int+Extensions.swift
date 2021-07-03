//
//  Formatter.swift
//  homeWork2.11
//
//  Created by Александра Мельникова on 30.06.2021.
//
import Foundation

extension Int {
    func formatting() -> String {
        var formatter: NumberFormatter {
            let format = NumberFormatter()
            
            format.numberStyle = .decimal
            format.groupingSeparator = " "
            return format
        }
        
        let formatted = String(describing: formatter.string(for: self) ?? "0")
        return formatted
    }
}
