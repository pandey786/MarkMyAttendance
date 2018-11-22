//
//  HomeRouter.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomeWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: HomeViewController = homeStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let navigationController = UINavigationController.init(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigationController
        
    }
    
    
    func presentNextController(for homeItem: HomeItem) {
        
        switch homeItem.homeItemId {
        case "1":
            let userRegistrationCtrl = UserRegistrationRouter.assembleModule()
            viewController?.navigationController?.pushViewController(userRegistrationCtrl, animated: true)
        default:
            break
        }
    }
}
