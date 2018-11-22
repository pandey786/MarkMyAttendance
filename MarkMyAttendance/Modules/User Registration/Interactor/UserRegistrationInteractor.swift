//
//  UserRegistrationInteractor.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class UserRegistrationInteractor: UserRegistrationUseCase {
    
    var output: UserRegistrationInteractorOutput!
    
    func registerUser(_ userStr: String, _ imageStr: String) {
        
        //Register user
        UserRecognitionAPIService.registerUser(imageStr, userStr) { (userRegistrationModel, isError, errorString) in
            
            //Check for Error
            if !isError {
                
                //No Error
                if let userRegistrationModelObj = userRegistrationModel {
                    
                    //User Registered successfully
                    self.output.userRegisteredSuccessfully(userRegistrationModelObj)
                } else {
                    
                    //User not Registered or data could not be parsed
                    self.output.userRegistrationFailed()
                }
            } else {
                
                //Error
                self.output.userRegistrationFailed()
            }
        }
    }
    
    func recognizeUser(_ imageStr: String) {
        
        //Recognize user
        UserRecognitionAPIService.recognizeUser(imageStr) { (userRecognitionModel, isError, errorString) in
            
            //Check for Error
            if !isError {
                
                //No Error
                if let userRecognitionModelObj = userRecognitionModel {
                    
                    //User Recognized successfully
                    self.output.userRecognizedSuccessfully(userRecognitionModelObj)
                } else {
                    
                    //User not Recognized or data could not be parsed
                    self.output.userRecognitionFailed()
                }
            } else {
                
                //Error
                self.output.userRecognitionFailed()
            }
        }
    }
}
