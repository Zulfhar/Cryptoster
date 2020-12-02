//
//  QuoteProvider.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 29/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation
import RealmSwift

protocol QuoteProviderDelegate {
    func updateUI()
}

class QuoteProvider {
    private let delegate: QuoteProviderDelegate?
    
    init(delegate: QuoteProviderDelegate) {
        self.delegate = delegate
    }
    
    func requestQuotes() {
        let quotesURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&price_change_percentagestring=1h"
        guard let url = URL(string: quotesURL) else {fatalError("Cannot create url.")}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let safeData = data else {
                print("Cannot get data.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Quote].self, from: safeData)
                self?.sendQuotes(quotes: decodedData)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func sendQuotes(quotes: [Quote]) {
        
        let realm = try! Realm()
        
        try! realm.write {
            for quote in quotes {
                let newCachedQuote = QuoteCached.convertToRealmModel(with: quote)
                realm.add(newCachedQuote, update: .modified)
            }
        }
        delegate?.updateUI()
    }
}
