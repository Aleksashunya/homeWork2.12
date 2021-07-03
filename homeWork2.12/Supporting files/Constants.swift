//
//  Constants.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 27.06.2021.
//

// MARK: Constants for API requests
import Alamofire

let headers: HTTPHeaders = [
    "x-rapidapi-key": "c0bdc88fc2msh1a2775b56982d71p1f2782jsnc18a6e23509e",
    "x-rapidapi-host": "covid-19-data.p.rapidapi.com" ]

enum URLs: String {
    case totalUrl = "https://covid-19-data.p.rapidapi.com/totals"
    case countryUrl = "https://covid-19-data.p.rapidapi.com/country?name="
}
