//
//  String+ Localized.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 29/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
