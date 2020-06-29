//
//  QuoteCached.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 1/5/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class QuoteCached: Object {
    
    dynamic var cachedId: String?
    dynamic var cachedSymbol: String = ""
    dynamic var cachedName: String = ""
    dynamic var cachedImage: String?
    dynamic var cachedPrice: Double = 0.0
    dynamic var cachedMarketcap: Int = 0
    dynamic var cachedMarketRank: Int = 0
    dynamic var cachedTotalVolume: Double = 0.0
    dynamic var cachedPriceChangePercentage: Double = 0.0
    dynamic var cachedCirculatingSupply: Double = 0.0
    dynamic var cachedTotalSupply: Int = 0
    dynamic var cachedPriceDate: String = ""
    
    dynamic var cachedHighPrice: Double = 0.0
    dynamic var cachedLowPrice: Double = 0.0
    dynamic var cachedPriceChange: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "cachedMarketRank"
    }
    
    class func convertToRealmModel(with quote: Quote) -> QuoteCached {
        let quoteCached = QuoteCached()
        
        quoteCached.cachedId = quote.id
        quoteCached.cachedMarketRank = quote.market_cap_rank
        quoteCached.cachedSymbol = quote.symbol
        quoteCached.cachedName = quote.name
        quoteCached.cachedImage = quote.image
        quoteCached.cachedPrice = quote.current_price
        quoteCached.cachedMarketcap = quote.market_cap
        quoteCached.cachedTotalVolume = quote.total_volume
        quoteCached.cachedCirculatingSupply = quote.circulating_supply
        quoteCached.cachedTotalSupply = quote.total_supply ?? 0
        quoteCached.cachedPriceChangePercentage = quote.price_change_percentage_24h ?? 0.0
        quoteCached.cachedPriceDate = quote.last_updated
        
        quoteCached.cachedHighPrice = quote.high_24h ?? 0.0
        quoteCached.cachedLowPrice = quote.low_24h ?? 0.0
        quoteCached.cachedPriceChange = quote.price_change_24h ?? 0.0
        
        return quoteCached
    }
}
