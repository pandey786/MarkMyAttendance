//
//  HomeViewController.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import CoreLocation

struct UserDetails {
    var userName: String?
    var empId: String?
}

class HomeViewController: UITableViewController {
    
    var presenter: HomePresentation!
    var userImagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    var searchBeaconTimer = Timer()
    var markAttendanceDialog: AZDialogViewController?
    
    var userDetails = UserDetails()
    
    //Data Source
    var homeItems: [HomeItem] = [] {
        didSet{
            
            //Reload Table
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view Setup
        setUpView()
        
        //Load View for Presenter
        presenter.viewDidLoad()
    }
    
    func setUpView() {
        
        //set Navigation bar
        setupNavigationBar()
        
        //set Dynamic height Of table View
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //set Deleagtes
        tableView.delegate = self
        tableView.dataSource = self
        
        //register Nib
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        //Add Spacing at top
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom:  0, right: 0)
        
        //Configure Location manager
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func setupNavigationBar() {
        
        //Set Large Title for Navigation Bar
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    fileprivate func takeUserImage() {
        userImagePicker.delegate = self
        userImagePicker.allowsEditing = true
        userImagePicker.sourceType = .camera
        userImagePicker.cameraCaptureMode = .photo
        userImagePicker.cameraDevice = .front
        userImagePicker.modalPresentationStyle = .fullScreen
        userImagePicker.showsCameraControls = true
        present(userImagePicker, animated: true, completion: nil)
    }
    
    func startMonitoringOfficeBeacon() {
        
        markAttendanceDialog?.message = "Connecting with Office System..."
        if let beaconRegion = officeBeaconRegion() {
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
        }
    }
    
    func stopMonitoringOfficeBeacon() {
        if let beaconRegion = officeBeaconRegion() {
            locationManager.stopMonitoring(for: beaconRegion)
            locationManager.stopRangingBeacons(in: beaconRegion)
        }
    }
    
    func isOfficeBeacon(_ beacon: CLBeacon) -> Bool {
        
        return ((beacon.proximityUUID.uuidString == "223F27A6-5433-4C39-8DE0-64F72EAB8AB5")
            && (Int(truncating: beacon.major) == 0)
            && (Int(truncating: beacon.minor) == 0))
    }
    
    func officeBeaconRegion() -> CLBeaconRegion? {
        
        if let uuid = UUID(uuidString: "223F27A6-5433-4C39-8DE0-64F72EAB8AB5") {
            return CLBeaconRegion(proximityUUID: uuid,
                                  major: CLBeaconMajorValue(0),
                                  minor: CLBeaconMinorValue(0),
                                  identifier: "MyOffice")
        }
        
        return nil
    }
    
    func startTimerForSearchingBeacons() {
        
        searchBeaconTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { [weak self] (timer) in
            
            guard let weakSelf = self else { return }
            weakSelf.searchBeaconTimer.invalidate()
            weakSelf.stopMonitoringOfficeBeacon()
            weakSelf.showDialogUserNotInOffice()
        }
    }
    
    func showDialogForAttendanceMarking() {
        
        markAttendanceDialog = AZDialogViewController(title: "Loading...", message: "Logging you in, please wait")
        
        if let container = markAttendanceDialog?.container {
            let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            markAttendanceDialog?.container.addSubview(indicator)
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            indicator.startAnimating()
        }
        
        //dialog.animationDuration = 5.0
        markAttendanceDialog?.customViewSizeRatio = 0.2
        markAttendanceDialog?.dismissDirection = .none
        markAttendanceDialog?.allowDragGesture = false
        markAttendanceDialog?.dismissWithOutsideTouch = true
        markAttendanceDialog?.show(in: self)
    }
    
    fileprivate func showDialogUserNotInOffice() {
        
        markAttendanceDialog?.title = "Failed"
        markAttendanceDialog?.message = "Hi, \(userDetails.userName ?? ""), You dont seems to be in Office. Please try to mark your attendance when in Office or raise the issue with our Customer Service Expert"
        markAttendanceDialog?.image = UIImage.init(named: "fail")
        markAttendanceDialog?.customViewSizeRatio = 0
        markAttendanceDialog?.dismissDirection = .bottom
        markAttendanceDialog?.allowDragGesture = true
    }
    
    fileprivate func showDialogUserNotBeIdentified() {
        
        markAttendanceDialog?.title = "Failed"
        markAttendanceDialog?.message = "Hi, We could not identify you. Please try again or raise the issue with our Customer Service Expert"
        markAttendanceDialog?.image = UIImage.init(named: "fail")
        markAttendanceDialog?.customViewSizeRatio = 0
        markAttendanceDialog?.dismissDirection = .bottom
        markAttendanceDialog?.allowDragGesture = true
    }
}

extension HomeViewController: HomeView {
    
    func showNoContentScreen() {
        //Show No Content Screen
    }
    
    func showHomeData(_ homeItems: [HomeItem]) {
        self.homeItems = homeItems
    }
    
    func userRecognizedSuccessfully(_ userRecognitionModel: UserRecognitionModel) {
        
        if let subjectId = userRecognitionModel.images?.first?.candidates?.first?.subject_id?.split(separator: "_"), let userName = subjectId.first, let empId = subjectId.last {
            
            userDetails.userName = String(userName)
            userDetails.empId = String(empId)
            
            startMonitoringOfficeBeacon()
            startTimerForSearchingBeacons()
            
        } else {
            showDialogUserNotBeIdentified()
        }
    }
    
    func userRecognitionFailed() {
        showDialogUserNotBeIdentified()
    }
}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeCell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let homeItem = self.homeItems[indexPath.row]
        homeCell.setUpCell(homeItem)
        
        homeCell.selectionStyle = .none
        
        return homeCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Navigate TO Next Screen based on selected Item
        let homeItem = self.homeItems[indexPath.row]
        
        if homeItem.homeItemId == "2" {
            takeUserImage()
        } else {
            presenter.didSelectHomeItem(homeItem)
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) { [weak self] in
            guard let weakSelf = self else { return }
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let imageStr = chosenImage.tobase64()
            
            weakSelf.showDialogForAttendanceMarking()
            weakSelf.markAttendanceDialog?.message = "Recognizing your Face..."
            weakSelf.presenter.recognizeUser(imageStr)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        for beacon in beacons {
            
            if isOfficeBeacon(beacon) {
                
                //Found Office Beacon
                searchBeaconTimer.invalidate()
                stopMonitoringOfficeBeacon()
                
                markAttendanceDialog?.message = "Marking your attendance..."
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
                    
                    guard let weakSelf = self else { return }
                    weakSelf.markAttendanceDialog?.title = "Success"
                    weakSelf.markAttendanceDialog?.message = "Your attendance marked successfully"
                    weakSelf.markAttendanceDialog?.image = UIImage.init(named: "success")
                    weakSelf.markAttendanceDialog?.customViewSizeRatio = 0
                    weakSelf.markAttendanceDialog?.dismissDirection = .bottom
                    weakSelf.markAttendanceDialog?.allowDragGesture = true
                }
            }
        }
    }
}
