//
//  ContentView.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm: CryptoListViewModel
    
    init(vm: CryptoListViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Crypto Price").padding()
            List(vm.cryptos, id:\.symbol) { crypto in
                HStack(alignment: .center) {
                    AsyncImage(url: URL(string: crypto.image),
                               content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30, maxHeight: 30)
                        
                    }, placeholder: {
                                ProgressView()
                            }
                    ).padding()
                    
                    Text(crypto.symbol
                            .uppercased()
                            .padding(toLength: 6, withPad: " ", startingAt: 0))
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("$\(crypto.current_price, specifier: "%.2f")")
                        .padding()
                }
                Divider()
            }.task {
                await vm.populateCryptos(cryptoNames: Constants.Cryptos.selectedCrypto())
            }
        }.frame(width: 300, height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm:CryptoListViewModel())
    }
}
