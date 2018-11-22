//
//  IndicatableViewExtension.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 29/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension IndicatableView where Self: UIViewController {
    
    func showActivityIndicator() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData) { (animation) in
        }
    }
    
    func hideActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
