//
//  AppUtilities.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 20/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

struct AppInstances {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}

// MARK: - UIView Extension
// MARK: -
extension UIView {
    
    func addDropShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.8)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false;
    }
    
    func addBorder() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = true
    }
    
    func addRoundedCorner() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
