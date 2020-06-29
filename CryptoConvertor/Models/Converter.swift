//
//  Converter.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 14/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

struct Converter {
    init(baseQuote: QuoteCached) {
        self.baseQuote = baseQuote
    }
    
    let baseQuote: QuoteCached
    
    func convert(currencyQuantity: Double, convertQuote: QuoteCached) -> String {
        return String(currencyQuantity*convertQuote.cachedPrice/baseQuote.cachedPrice)
    }
}
