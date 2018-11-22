//
//  UserRegistrationPresenter.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class UserRegistrationPresenter: UserRegistrationPresentation {
    
    var view: UserRegistrationView?
    var interactor: UserRegistrationUseCase!
    var router: UserRegistrationWireframe!
    
    var userRegistrationModel: UserRegistrationModel?
    
    func viewDidLoad() {
        
    }
    
    func registerUser(_ userStr: String, _ imageStr: String) {
        interactor.registerUser(userStr, imageStr)
        view?.showActivityIndicator()
    }
    
    func recognizeUser(_ imageStr: String) {
        view?.showActivityIndicator()
        interactor.recognizeUser(imageStr)
    }
}

extension UserRegistrationPresenter: UserRegistrationInteractorOutput {
    
    func userRegisteredSuccessfully(_ userRegistrationModel: UserRegistrationModel) {
        self.userRegistrationModel = userRegistrationModel
        view?.showUserRegistrationData(userRegistrationModel)
        view?.hideActivityIndicator()
    }
    
    func userRegistrationFailed() {
        view?.hideActivityIndicator()
        view?.showNoContentScreen()
    }
    
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel) {
        view?.userRecognizedSuccessfully(userRecognitionModel)
        view?.hideActivityIndicator()
    }
    
    func userRecognitionFailed() {
        view?.userRecognitionFailed()
        view?.hideActivityIndicator()
    }
}
