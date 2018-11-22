//
//  UserRegistrationAPIService.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 20/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UserRecognitionAPIService {
    
    static func registerUser(_ imageStr: String, _ userStr: String, completionHandler: @escaping (_ userRegistrationModel: UserRegistrationModel?, _ isError: Bool, _ error: String?) -> ()) {
        
        let userRegistrationUrl = "https://api.kairos.com/enroll"
        let bodyObject: [String : Any] = [
            "image": imageStr,
            "gallery_name": "MyGallery",
            "subject_id": userStr,
            ]
        
        let header: [String : String] = [
            "app_key": "ca9c3d7c04168ab2d9273abf83805861",
            "app_id": "39ea2f98",
            "Content-Type": "Durgesh_Pandey"
        ]
        
        Alamofire.request(userRegistrationUrl, method: .post, parameters: bodyObject, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseString(completionHandler: { (responseString) in
                print(responseString.value ?? "Could not get proper response")
            })
            .responseObject { (response: DataResponse<UserRegistrationModel>) in
                
                switch response.result {
                case .success(let userRegistrationModel):
                    
                    //Response received successfully
                    completionHandler(userRegistrationModel, false, nil)
                    break
                case .failure(let error):
                    
                    //There was an error
                    completionHandler(nil, true, error.localizedDescription)
                    break
                }
        }
    }
    
    static func recognizeUser(_ imageStr: String, completionHandler: @escaping (_ userRecognitionModel: UserRecognitionModel?, _ isError: Bool, _ error: String?) -> ()) {
        
        let userRecognitionUrl = "https://api.kairos.com/recognize"
        let bodyObject: [String : Any] = [
            "image": imageStr,
            "gallery_name": "MyGallery",
            ]
        
        let header: [String : String] = [
            "app_key": "ca9c3d7c04168ab2d9273abf83805861",
            "app_id": "39ea2f98",
            "Content-Type": "Durgesh_Pandey"
        ]
        
        Alamofire.request(userRecognitionUrl, method: .post, parameters: bodyObject, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseString(completionHandler: { (responseString) in
                print(responseString.value ?? "Could not get proper response")
            })
            .responseObject { (response: DataResponse<UserRecognitionModel>) in
                
                switch response.result {
                case .success(let userRecognitionModel):
                    
                    //Response received successfully
                    completionHandler(userRecognitionModel, false, nil)
                    break
                case .failure(let error):
                    
                    //There was an error
                    completionHandler(nil, true, error.localizedDescription)
                    break
                }
        }
    }
}
