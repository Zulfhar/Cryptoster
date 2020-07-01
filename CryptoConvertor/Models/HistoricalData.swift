//
//  HistoricalData.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 1/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

struct HistoricalData: Decodable {
    let prices: [[Double]]
}
