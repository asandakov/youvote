//
//  SplashPresenter.swift
//  YouVote
//
//  Created by Алексей on 28.05.2021.
//

import Foundation

class SplashPresenter: SplashViewPresenterProtocol, SplashInteractorPresenterProtocol {
   
    weak var view: SplashViewControllerProtocol!
    var interactor: SplashInteractorProtocol!
    var router: SplashRouterProtocol!
   
    
    required init(view: SplashViewControllerProtocol) {
          self.view = view
    }
       
    
    func start() {
        interactor.onLogon()
    }
    
    func showAlert(message: String) {
        self.view.showMessage(message: message)
    }
    
    
    func isAuth(auth: Bool){
        self.router.showMainScene(auth:auth)
    }

    deinit {
        print("deinit: "+String(describing: self))
    }
}
