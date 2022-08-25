//
//  Constants.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let coinGeckoApiUrl: (String) -> URL = { return URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\($0)")!
        }
    }
    
    struct Cryptos {
        static let secret = "secret"
        static let atom = "cosmos"
        static let osmo = "osmosis"
        static let juno = "juno-network"
        static let cro = "crypto-com-chain"
        static let luna = "terra-luna"
        static let evmos = "evmos"
        
        static let selectedCrypto: () -> [String] = {
            return [
                Self.atom,
                Self.osmo,
                Self.juno,
                Self.evmos,
                Self.secret
            ]
        }
    }
}
