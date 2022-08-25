//
//  Crypto.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import Foundation

struct Crypto: Decodable {
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let price_change_24h : Double
}
