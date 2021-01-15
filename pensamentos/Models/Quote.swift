//
//  Quote.swift
//  pensamentos
//
//  Created by Rodrigo Queiroz on 06/08/20.
//  Copyright © 2020 Rodrigo Queiroz. All rights reserved.
//

import Foundation

struct Quote: Codable {
    
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatted: String {
        return " “" + quote + "” "
    }
    
    var authorFormatted: String {
        return "- " + author + " -"
    }
}
