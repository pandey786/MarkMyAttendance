//
//  UserRegistrationViewController.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

struct UserFaceDetails {
    var imageString: String?
    var userString: String?
}

class UserRegistrationViewController: UIViewController {
    
    @IBOutlet weak var viewRegisterWithFace: UIView!
    @IBOutlet weak var textFieldEmployeeId: UITextField!
    @IBOutlet weak var textFieldUserName: UITextField!
    
    var userRecognitionDialog: AZDialogViewController?
    var presenter: UserRegistrationPresentation!
    var userImagePicker = UIImagePickerController()
    var userDetails = UserDetails()
    var userFaceDetails = UserFaceDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View setup
        setUpView()
    }
    
    private func setUpView() {
        viewRegisterWithFace.addRoundedCorner()
    }
    
    private func validUserInput() -> (validUserInput: Bool, errorMessage: String?) {
        
        if let userName = textFieldUserName.text, let empId = textFieldEmployeeId.text {
            
            if userName.isEmpty && empId.isEmpty {
                return (false, "Please Enter Employee Name and Employee Id")
            } else if userName.isEmpty {
                return (false, "Please Enter Employee Name")
            } else if empId.isEmpty {
                return (false, "Please Enter Employee Id")
            } else {
                return (true, nil)
            }
        }
        
        return (false, "Please Enter Employee Name and Employee Id")
    }
    
    @IBAction func buttonRegisterWithFaceTapped(_ sender: Any) {
        
        if validUserInput().validUserInput {
            
            userImagePicker.delegate = self
            userImagePicker.allowsEditing = true
            userImagePicker.sourceType = .camera
            userImagePicker.cameraCaptureMode = .photo
            userImagePicker.cameraDevice = .front
            userImagePicker.modalPresentationStyle = .fullScreen
            userImagePicker.showsCameraControls = true
            present(userImagePicker, animated: true, completion: nil)
            
        } else {
            
            let dialogController = AZDialogViewController(title: "Error",
                                                          message: validUserInput().errorMessage ?? "Something went wrong")
            
            dialogController.showSeparator = true
            dialogController.dismissDirection = .bottom
            dialogController.blurBackground = true
            dialogController.blurEffectStyle = .dark
            dialogController.dismissWithOutsideTouch = true
            
            // Add Action
            dialogController.addAction(AZDialogAction(title: "Ok", handler: { (dialog) -> (Void) in
                dialogController.dismiss()
            }))
            
            dialogController.show(in: self)
        }
    }
    
    func registerCurrentUser() {
        
        //Call API to register the User
        if let userStr = userFaceDetails.userString, let imageStr = userFaceDetails.imageString {
            presenter.registerUser(userStr, imageStr)
        }
    }
}

extension UserRegistrationViewController: UserRegistrationView {
    
    func showNoContentScreen() {
        
    }
    
    func showUserRegistrationData(_ userRegistrationModel: UserRegistrationModel) {
        
        //user Registered Successfully
        if let userName = userRegistrationModel.images?.first?.transaction?.subject_id?.split(separator: "_").first {
            
            let successMessageStr = "Hey \(userName), You have registered successfully. Please go to Login page to mark your attendance."
            showDialog("Success", successMessageStr)
        }
    }
    
    fileprivate func showDialog(_ title: String, _ message: String) {
        
        let dialogController = AZDialogViewController(title: title,
                                                      message: message)
        
        dialogController.showSeparator = true
        dialogController.dismissDirection = .bottom
        dialogController.blurBackground = true
        dialogController.blurEffectStyle = .dark
        dialogController.dismissWithOutsideTouch = true
        
        // Add Action
        dialogController.addAction(AZDialogAction(title: "Go to Login", handler: { (dialog) -> (Void) in
            dialogController.dismiss(animated: false, completion: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.navigationController?.popViewController(animated: true)
            })
        }))
        
        dialogController.show(in: self)
    }
    
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel) {
        
        if let transactionStatus = userRecognitionModel.images?.first?.transaction?.status, let subjectId = userRecognitionModel.images?.first?.candidates?.first?.subject_id?.split(separator: "_"), let userName = subjectId.first, let empId = subjectId.last {
            
            if transactionStatus == "success" {
                
                //User Already Registered
                userDetails.userName = String(userName)
                userDetails.empId = String(empId)
                
                let message = "Hey, you are already registered. Please verify your details below:- \n Name:- \(userName)\n EmpID:- \(empId).\n Please continue to mark your attendance for today."
                
                let dialogController = AZDialogViewController(title: "Alert",
                                                              message: message)
                
                dialogController.showSeparator = true
                dialogController.dismissDirection = .bottom
                dialogController.blurBackground = true
                dialogController.blurEffectStyle = .dark
                dialogController.dismissWithOutsideTouch = true
                
                // Add Action
                dialogController.addAction(AZDialogAction(title: "Mark Attendance", handler: { (dialog) -> (Void) in
                    dialogController.dismiss(animated: false, completion: { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.navigationController?.popViewController(animated: true)
                    })
                }))
                
                dialogController.show(in: self)
                
            } else {
                registerCurrentUser()
            }
            
        } else {
            registerCurrentUser()
        }
    }
    
    func userRecognitionFailed() {
        //showDialogUserNotBeIdentified()
    }
    
}

extension UserRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) { [weak self] in
            
            guard let weakSelf = self else { return }
            if let userName = weakSelf.textFieldUserName.text, let empId = weakSelf.textFieldEmployeeId.text {
                let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                let imageStr = chosenImage.tobase64()
                let userStr = "\(userName)_\(empId)"
                
                weakSelf.userFaceDetails.userString = userStr
                weakSelf.userFaceDetails.imageString = imageStr
                weakSelf.presenter.recognizeUser(imageStr)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
