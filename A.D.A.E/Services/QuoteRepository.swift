//
//  QuoteRepository.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 22/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import Foundation

class QuoteRepository {
    
    static func getQuote(completionHandler: @escaping (Quote) -> Void) {
        
        let path: String = "https://quotes.rest/qod/"
        let url: URL = URL(string: path)!
        
        //GET
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let res = response as? HTTPURLResponse else {
                print("Erou! Response nao é HTTP")
                return
            }
            
            if res.statusCode == 200 {
                if let quoteJSON = try? JSONDecoder().decode(QuotesJSON.self, from: data!) {
                    if let quote = quoteJSON.contents.quotes.first {
                        completionHandler(quote)
                    }
                }
            }
            
        }.resume()
    
    }
}
