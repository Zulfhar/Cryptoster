//
//  QuoteDetailViewController.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 17/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import Charts

class QuoteDetailViewController: UIViewController, ChartViewDelegate {
    
    var singleQuote: QuoteCached?
    var dataArray = [[Double]]()
    var lineChart = LineChartView()
    var urlBase = "https://api.coingecko.com/api/v3/coins"
    
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
        
        setLabels()
        timeButton.forEach { button in
            button.layer.cornerRadius = 10
        }

        lineChart.delegate = self
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineChart)
        
        NSLayoutConstraint.activate([
            lineChart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            lineChart.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            lineChart.topAnchor.constraint(equalTo: timeButton.first!.bottomAnchor, constant: 10),
            lineChart.bottomAnchor.constraint(equalTo: highestPriceLabel.topAnchor, constant: -10)
        ])
        
        if let coin = singleQuote?.cachedId {
            fetchGraph(for: coin)
        }
    }
    
    func fetchGraph(for coin: String, days: Int = 1) {
        guard let url = URL(string: "\(urlBase)/\(coin)/market_chart?id=\(coin)&vs_currency=usd&days=\(days)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {fatalError()}
            guard let safeData = data else {fatalError()}
            guard let decodedData = try? JSONDecoder().decode(HistoricalData.self, from: safeData) else {fatalError()}
            self.dataArray = decodedData.prices
            
            self.drawGraphic()
        }.resume()
    }
    
    func drawGraphic() {
        var entries = [ChartDataEntry]()
        
        for x in 0..<dataArray.count {
            entries.append((ChartDataEntry(x: Double(x), y: dataArray[x][1])))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Price")
        set.drawCirclesEnabled = false
        let graphColor = NSUIColor.init(named: "graphColor")
        set.setColors(graphColor!)
        let data = LineChartData(dataSet: set)
        DispatchQueue.main.async {
            self.lineChart.data = data
        }
    }
    
    func setLabels() {
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
    
    @IBAction func timeIntervalSelected(_ sender: UIButton) {
        let title = sender.titleLabel?.text
        guard let coin = singleQuote?.cachedId else {return}
        
        if title == "Day" {
            fetchGraph(for: coin, days: 1)
        } else if title == "Week" {
            fetchGraph(for: coin, days: 7)
        } else {
            fetchGraph(for: coin, days: 365)
        }
    }
    
}
