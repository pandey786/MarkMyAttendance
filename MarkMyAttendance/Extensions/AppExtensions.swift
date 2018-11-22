//
//  AppExtensions.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 20/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    var highestQualityJPEGNSData:NSData { return UIImageJPEGRepresentation(self, 1.0)! as NSData }
    var highQualityJPEGNSData:NSData    { return UIImageJPEGRepresentation(self, 0.75)! as NSData}
    var mediumQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.5)! as NSData }
    var lowQualityJPEGNSData:NSData     { return UIImageJPEGRepresentation(self, 0.25)! as NSData}
    var lowestQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.0)! as NSData }
    
    func tobase64() -> String {
        var base64String = ""
        let  cim = CIImage(image: self)
        if (cim != nil) {
            let imageData = self.lowQualityJPEGNSData
            base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        }
        return base64String
    }
}
