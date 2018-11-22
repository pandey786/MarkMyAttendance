//
//  HomeTableViewCell.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(_ homeItem: HomeItem) {
        viewBackground.addRoundedCorner()
        viewBackground.addDropShadow()
        
        switch homeItem.homeItemId {
        case "1":
            imageViewIcon.image = UIImage.init(named: "register")
            labelTitle.text = "Register"
        case "2":
            imageViewIcon.image = UIImage.init(named: "login")
            labelTitle.text = "Login"
        default:
            break
        }
    }
}
