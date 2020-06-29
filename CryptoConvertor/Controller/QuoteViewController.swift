//
//  ViewController.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 14/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder
import AnimatableReload
import RealmSwift
import AVFoundation

class QuoteViewController: UITableViewController {
    
    let realm = try! Realm()
    var cachedCurrencies: Results<QuoteCached>?
    
    var isSelectQuoteMode = false
    var hasAlreadyLaunched: Bool!
    
    private var quoteProvider: QuoteProvider?
    private var isAnimatableList = true
    
    var player: AVAudioPlayer!
    let cellid = "QuoteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.register(QuoteCell.self, forCellReuseIdentifier: cellid)
        tableView.separatorStyle = .none
        
        quoteProvider = QuoteProvider(delegate: self)
        quoteProvider?.requestQuotes()
        
        tableView.rowHeight = 80
        tableView.separatorColor = UIColor.blue
        
        cachedCurrencies = realm.objects(QuoteCached.self)
    }
    
    @IBAction func refreshQuotes(_ sender: Any?) {
        playSound()
        isAnimatableList = true
        quoteProvider?.requestQuotes()
    }
    
    //MARK: - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cachedCurrencies?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! QuoteCell
        
        if let coin = cachedCurrencies?[indexPath.row], let logoURL = coin.cachedImage {
            cell.logoImageView.sd_setImage(with: URL(string: logoURL))
            cell.symbolLabel.text = coin.cachedSymbol.uppercased()
            cell.priceLabel.text = String(format: "$%.2f", coin.cachedPrice)
            cell.priceChangeLabel.text = String(format: "%.3f", coin.cachedPriceChangePercentage) + "%"
            if let priceChangeString = cell.priceChangeLabel.text, coin.cachedPriceChangePercentage > 0.0 {
                cell.priceChangeLabel.text = "+\(priceChangeString)"
                cell.priceChangeLabel.textColor = UIColor(named: "upwardPrice")
            } else {
                cell.priceChangeLabel.textColor = UIColor(named: "downwardPrice")
            }
            cell.rankLabel.text = String(coin.cachedMarketRank)
            cell.nameLabel.text = coin.cachedName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    //MARK: - Observer method
    
    @objc func receiveNotification(notification: Notification) {
        quoteProvider?.requestQuotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        if !hasAlreadyLaunched {
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
            firstLaunch()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: notificationSendQuotes, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - TableView Delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectQuoteMode {
            isSelectQuoteMode = false
            let selectedQuote = cachedCurrencies?[indexPath.row]
            NotificationCenter.default.post(name: notificationSendSelectedQuote, object: selectedQuote)
            dismiss(animated: true, completion: nil)
            return
        }
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        playSound()
        if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as? QuoteDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC?.singleQuote = cachedCurrencies?[indexPath.row]
            }
        }
    }
    
    func firstLaunch() {
        let alert = UIAlertController(title: "First Launch", message: "Welcome to CryptoApp!", preferredStyle: .alert)
        present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    func playSound(soundName: String = "C") {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}

extension QuoteViewController: QuoteProviderDelegate {
    func updateUI() {
        if !isSelectQuoteMode && isAnimatableList {
            DispatchQueue.main.async {
                AnimatableReload.reload(tableView: self.tableView, animationDirection: "right")
            }
            isAnimatableList = false
        }
        else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
