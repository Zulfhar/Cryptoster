//
//  QuoteCell.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 27/6/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

class QuoteCell: UITableViewCell {

    var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "background")?.cgColor
        view.backgroundColor = UIColor(named: "background")
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1

        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor(named: "nameLabelColor")?.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.masksToBounds = false;
        view.clipsToBounds = false;
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
        return view
    }()
    var rankLabel: UILabel = {
        let rankLabel = UILabel()
        rankLabel.textColor = UIColor(named: "nameLabelColor")
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        return rankLabel
    }()
    var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(named: "nameLabelColor")
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    var symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textColor = UIColor(named: "symbolLabelColor")
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        return symbolLabel
    }()
    var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = UIColor(named: "nameLabelColor")
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    var priceChangeLabel: UILabel = {
        let priceChangeLabel = UILabel()
        priceChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceChangeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(rankLabel)
        containerView.addSubview(logoImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(symbolLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(priceChangeLabel)
        
        NSLayoutConstraint.activate([
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            rankLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            logoImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            
            symbolLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            symbolLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            priceChangeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            priceChangeLabel.bottomAnchor.constraint(equalTo: symbolLabel.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
