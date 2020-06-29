//
//  QuoteProvider.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 17/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

let notificationSendQuotes = Notification.Name("notification_quotes")
let notificationSendSelectedQuote = Notification.Name("notification_selected_quote")

class NotificationProvider {
    
    private var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            NotificationCenter.default.post(name: notificationSendQuotes, object: nil)
        })
    }
    
    func stop() {
        timer?.invalidate()
    }
}
