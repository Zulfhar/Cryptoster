//
//  ConvertViewController.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 26/4/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import SDWebImage

class ConvertViewController: UIViewController {
    
    var selectedQuote = ""
    var selectedBaseQuote: QuoteCached?
    var selectedConvertingQuote: QuoteCached?
    
    @IBOutlet weak var baseQuoteButton: UIButton!
    @IBOutlet weak var baseQuoteLabel: UILabel!
    @IBOutlet weak var baseQuotePrice: UILabel!
    @IBOutlet weak var baseQuoteField: UITextField!
    
    @IBOutlet weak var convertingQuoteButton: UIButton!
    @IBOutlet weak var convertingQuoteLabel: UILabel!
    @IBOutlet weak var convertingQuotePrice: UILabel!
    @IBOutlet weak var convertingQuoteField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveSelectedQuote), name: notificationSendSelectedQuote, object: nil)
        baseQuoteField?.delegate = self
        convertingQuoteField?.delegate = self
        
        baseQuoteButton.layer.cornerRadius = 30.0
        convertingQuoteButton.layer.cornerRadius = 30.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.268055141, blue: 0.4435406923, alpha: 1)
        }) { (finished) in
            UIView.animate(withDuration: 0.2) {
                self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    @objc func receiveSelectedQuote(notification: Notification) {
        if let notifiedQuote = notification.object as? QuoteCached {
            let imageView = UIImageView()
            if let url = URL(string: notifiedQuote.cachedImage!) {
                imageView.sd_setImage(with: url)
            }
            if selectedQuote == "baseQuote" {
                selectedBaseQuote = notifiedQuote
                DispatchQueue.main.async {
                    self.baseQuoteButton.setTitle("", for: .normal)
                    self.baseQuoteButton.backgroundColor = .white
                    self.baseQuoteButton.setBackgroundImage(imageView.image, for: .normal)
                    self.baseQuoteLabel.text = self.selectedBaseQuote?.cachedSymbol
                    self.baseQuotePrice.text = String(format: "$%.3f", self.selectedBaseQuote?.cachedPrice ?? 0.0)
                }
            } else if selectedQuote == "convertingQuote" {
                selectedConvertingQuote = notifiedQuote
                DispatchQueue.main.async {
                    self.convertingQuoteButton.setTitle("", for: .normal)
                    self.convertingQuoteButton.backgroundColor = .white
                    self.convertingQuoteButton.setBackgroundImage(imageView.image, for: .normal)
                    self.convertingQuoteLabel.text = String(self.selectedConvertingQuote?.cachedPrice ?? 0.0)
                    self.convertingQuotePrice.text = String(format: "$%.3f", self.selectedConvertingQuote?.cachedPrice ?? 0.0)
                }
            }
        }
    }
    
    @IBAction func baseQuoteSelected(_ sender: UIButton) {
        selectedQuote = "baseQuote"
        performSegue(withIdentifier: "goToSelectQuote", sender: self)
    }
    
    @IBAction func convertingQuoteSelected(_ sender: UIButton) {
        selectedQuote = "convertingQuote"
        performSegue(withIdentifier: "goToSelectQuote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? QuoteViewController
        destinationVC?.isSelectQuoteMode = true
    }
    
}

extension ConvertViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let firstQuote = selectedBaseQuote, let secondQuote = selectedConvertingQuote else {
            return
        }
        if baseQuoteField.isEditing && baseQuoteField.text != "" {
            let baseQuote = Converter(baseQuote: secondQuote)
            var num: Double? {
                return Double(baseQuoteField.text!)
            }
            convertingQuoteField.text = baseQuote.convert(currencyQuantity: num!, convertQuote: firstQuote)
        } else if convertingQuoteField.isEditing && convertingQuoteField.text != "" {
            let baseQuote = Converter(baseQuote: firstQuote)
            var num: Double? {
                return Double(convertingQuoteField.text!)
            }
            baseQuoteField.text = baseQuote.convert(currencyQuantity: num!, convertQuote: secondQuote)
        }
    }
    
}
