//
//  QuoteManager.swift
//  pensamentos
//
//  Created by Rodrigo Queiroz on 06/08/20.
//  Copyright © 2020 Rodrigo Queiroz. All rights reserved.
//

import Foundation

class QuoteManager {
    
    let quotes: [Quote]
    
    init() {
        
        let jsonPath = Bundle.main.url(forResource: "quotes", withExtension: "json")!
        
        let jsonData = try! Data(contentsOf: jsonPath)
        
        quotes = try! JSONDecoder().decode([Quote].self, from: jsonData)
        
    }
    
    func getRandomQuote() -> Quote {
        
        let index = Int(arc4random_uniform(UInt32(quotes.count)))
        
        return quotes[index]
    }
    
}
