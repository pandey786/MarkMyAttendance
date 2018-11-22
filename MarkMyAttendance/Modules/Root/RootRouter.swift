//
//  RootRouter.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 29/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    func presentHomeScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = HomeRouter.assembleModule()
    }
}
