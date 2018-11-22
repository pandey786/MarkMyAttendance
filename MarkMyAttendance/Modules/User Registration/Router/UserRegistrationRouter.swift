//
//  UserRegistrationRouter.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class UserRegistrationRouter: UserRegistrationWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: UserRegistrationViewController = userRegistrationStoryBoard.instantiateViewController(withIdentifier: "UserRegistrationViewController") as! UserRegistrationViewController
        
        let presenter = UserRegistrationPresenter()
        let interactor = UserRegistrationInteractor()
        let router = UserRegistrationRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
}
