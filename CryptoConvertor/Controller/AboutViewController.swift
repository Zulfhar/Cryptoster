//
//  AboutViewController.swift
//  CryptoConvertor
//
//  Created by Zulfkhar Maukey on 10/5/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    

}
