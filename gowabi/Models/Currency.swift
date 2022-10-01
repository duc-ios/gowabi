//
//  Currency.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation

struct Currency: Codable {
    let id: Int
    let label: String
}

struct CurrenciesResponse: Codable {
    let currencies: [Currency]
}
