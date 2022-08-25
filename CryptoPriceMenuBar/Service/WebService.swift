//
//  WebService.swift
//  CryptoPriceMenuBar
//
//  Created by Juan on 23/08/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

class WebService {
    
    func getCrypto(url: URL) async throws -> [Crypto] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw NetworkError.invalidResponse
              }
        
        return try JSONDecoder().decode([Crypto].self, from: data)
    }
    
}
