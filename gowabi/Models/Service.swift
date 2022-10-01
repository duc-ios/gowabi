//
//  Service.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation

struct Service: Codable {
    let id: Int
    let currency_id: Int
    let name: String
    let price: Int
    
    func formattedName(currency: Currency) -> String {
        "\(name) (\(currency.label))"
    }
}

struct ServiceResponse: Codable {
    let services: [Service]
}
