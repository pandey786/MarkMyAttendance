//
//  HomeInteractor.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class HomeInteractor: HomeUseCase {
    
    var output: HomeInteractorOutput!
    
    func fetchHomeData() {
        
        //Create home Data Items and send to Output Interactor
        let homeItem1 = HomeItem.init(homeItemId: "1", homeItemName: "Mark My Attendence")
        let homeItem2 = HomeItem.init(homeItemId: "2", homeItemName: "Register User")
        
        let homeItems = [homeItem1, homeItem2]
        
        //Pass this data to Interactor
        self.output.homeDataFetchedSuccessfully(homeItems)
        
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
