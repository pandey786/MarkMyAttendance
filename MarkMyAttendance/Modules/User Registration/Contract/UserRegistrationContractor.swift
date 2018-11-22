//
//  UserRegistrationContractor.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol UserRegistrationView: IndicatableView {
    
    var presenter: UserRegistrationPresentation!{ get set }
    
    func showUserRegistrationData(_ userRegistrationModel: UserRegistrationModel)
    func showNoContentScreen()
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel)
    func userRecognitionFailed()
}

protocol UserRegistrationPresentation: class {
    
    var view: UserRegistrationView? { get set }
    var interactor: UserRegistrationUseCase! { get set }
    var router: UserRegistrationWireframe! { get set }
    
    func viewDidLoad()
    func registerUser(_ userStr: String, _ imageStr: String)
    func recognizeUser(_ imageStr: String)
}

protocol UserRegistrationUseCase: class {
    
    var output: UserRegistrationInteractorOutput! { get set }
    
    func registerUser(_ userStr: String, _ imageStr: String)
    func recognizeUser(_ imageStr: String)
}

protocol UserRegistrationInteractorOutput: class {
    
    func userRegisteredSuccessfully(_ userRegistrationModel: UserRegistrationModel)
    func userRegistrationFailed()
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel)
    func userRecognitionFailed()
}

protocol UserRegistrationWireframe: class {
    
    var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
}
