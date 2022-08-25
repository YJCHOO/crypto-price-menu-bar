//
//  CryptoListViewModel.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import Foundation


@MainActor
class CryptoListViewModel: ObservableObject {
    
    @Published var cryptos: [CryptoViewModel] = []
     
    func populateCryptos(cryptoNames: [String]) async {
        
        do {
            var cryptos:[Crypto]=[]
            
            for cryptoName in cryptoNames {
                let cryptoInfo = try await WebService().getCrypto(url: Constants.Urls.coinGeckoApiUrl(cryptoName))
                cryptos += cryptoInfo
            }
            //let cryptos = try await WebService().getCrypto(url: Constants.Urls.coinGeckoApiUrl(Constants.Cryptos.evmos))
            
            self.cryptos = cryptos.map(CryptoViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct CryptoViewModel {
    
    private var crypto: Crypto
    
    init(crypto: Crypto) {
        self.crypto = crypto
    }
    
    var symbol: String {
        crypto.symbol
    }
    
    var name: String {
        crypto.name
    }
    
    var image: String {
        crypto.image
    }
    
    var current_price: Double {
        crypto.current_price
    }
    
    var price_change_24h: Double {
        crypto.price_change_24h
    }
}
