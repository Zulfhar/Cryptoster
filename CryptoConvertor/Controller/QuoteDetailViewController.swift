//
//  QuoteDetailViewController.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 17/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    var singleQuote: QuoteCached?
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var priceChangePercentageLabel: UILabel!
    @IBOutlet weak var percentageChangeLabel: UILabel!
    @IBOutlet weak var highestPriceLabel: UILabel!
    @IBOutlet weak var lowestPriceLabel: UILabel!
    @IBOutlet var timeButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeButton.forEach { button in
            button.layer.cornerRadius = 10
        }
        
        if let quoteUnwrapped = singleQuote {
            self.navigationItem.title = quoteUnwrapped.cachedName
            
            if let url = URL(string: quoteUnwrapped.cachedImage!) {
                self.logoImage.sd_setImage(with: url)
            }
            currentPriceLabel.text = String(format: "$%.2f", quoteUnwrapped.cachedPrice)
                
            priceChangeLabel.text = String(format: "%.2f", quoteUnwrapped.cachedPriceChange)
            if let priceChangeString = priceChangeLabel.text , quoteUnwrapped.cachedPriceChange >= 0 {
                priceChangeLabel.text = "+ $\(priceChangeString)"
            } else if quoteUnwrapped.cachedPriceChange < 0 {
                priceChangeLabel.text = String(format: "- $%.2f", abs(quoteUnwrapped.cachedPriceChange))
            }
            
            priceChangePercentageLabel.text = String(format: "%.2f%", quoteUnwrapped.cachedPriceChangePercentage)
            percentageChangeLabel.text = String(format: "%.2f%", quoteUnwrapped.cachedPriceChangePercentage)
            if let priceChangePercentageString = priceChangePercentageLabel.text, quoteUnwrapped.cachedPriceChangePercentage >= 0 {
                priceChangePercentageLabel.text = "↗\(priceChangePercentageString)"
                priceChangePercentageLabel.textColor = UIColor(named: "upwardPrice")
                
                percentageChangeLabel.text = "+ \(priceChangePercentageString)"
            } else if quoteUnwrapped.cachedPriceChangePercentage < 0 {
                priceChangePercentageLabel.text = String(format: "↙%.2f", abs(quoteUnwrapped.cachedPriceChangePercentage)) + "%"
                priceChangePercentageLabel.textColor = UIColor(named: "downwardPrice")
                
                percentageChangeLabel.text = String(format: "- %.2f", abs(quoteUnwrapped.cachedPriceChangePercentage)) + "%"
            }
            
            highestPriceLabel.text = String(format: "$%.2f", quoteUnwrapped.cachedHighPrice)
            lowestPriceLabel.text = String(format: "$%.2f", quoteUnwrapped.cachedLowPrice)
            
            
        }
    }
    
}
