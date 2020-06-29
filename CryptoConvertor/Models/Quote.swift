//
//  Quote.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 14/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

class Quote: Codable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Double
    var market_cap: Int
    var market_cap_rank: Int
    var total_volume: Double
    var price_change_percentage_24h: Double?
    var circulating_supply: Double
    var total_supply: Int?
    var last_updated: String
    
    var high_24h: Double?
    var low_24h: Double?
    var price_change_24h: Double?
}
