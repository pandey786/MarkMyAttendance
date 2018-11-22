//
//  HomePresenter.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class HomePresenter: HomePresentation {
    
    var view: HomeView?
    var interactor: HomeUseCase!
    var router: HomeWireframe!
    
    var homeItems: [HomeItem] = [] {
        didSet {
            if homeItems.count > 0 {
                view?.showHomeData(homeItems)
            } else {
                view?.showNoContentScreen()
            }
        }
    }
    
    func viewDidLoad() {
        
        view?.showActivityIndicator()
        interactor.fetchHomeData()
    }
    
    func didSelectHomeItem(_ homeItem: HomeItem) {
        router.presentNextController(for: homeItem)
    }
    
    func recognizeUser(_ imageStr: String) {
        //view?.showActivityIndicator()
        interactor.recognizeUser(imageStr)
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func homeDataFetchedSuccessfully(_ homeItems: [HomeItem]) {
        self.homeItems = homeItems
        view?.hideActivityIndicator()
    }
    
    func homeDataFetchFailed() {
        view?.showNoContentScreen()
        view?.hideActivityIndicator()
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
