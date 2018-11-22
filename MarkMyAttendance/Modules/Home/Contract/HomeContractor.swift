//
//  HomeContractor.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol HomeView: IndicatableView {
    
    var presenter: HomePresentation!{ get set }
    
    func showNoContentScreen()
    func showHomeData(_ homeItems: [HomeItem])
    
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel)
    func userRecognitionFailed()
}

protocol HomePresentation: class {
    
    var view: HomeView? { get set }
    var interactor: HomeUseCase! { get set }
    var router: HomeWireframe! { get set }
    
    func viewDidLoad()
    func didSelectHomeItem(_ homeItem: HomeItem)
    func recognizeUser(_ imageStr: String)
}

protocol HomeUseCase: class {
    
    var output: HomeInteractorOutput! { get set }
    
    func fetchHomeData()
    func recognizeUser(_ imageStr: String)
}

protocol HomeInteractorOutput: class {
    
    func homeDataFetchedSuccessfully(_ homeItems: [HomeItem])
    func homeDataFetchFailed()
    
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel)
    func userRecognitionFailed()
}

protocol HomeWireframe: class {
    
    var viewController: UIViewController? { get set }
    
    func presentNextController(for homeItem: HomeItem)
    
    static func assembleModule() -> UIViewController
}
