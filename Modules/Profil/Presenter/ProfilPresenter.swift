//
//  ProfilPresenter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class ProfilPresenter: ProfilViewPresenterProtocol, ProfilInteractorPresenterProtocol {
    
    weak var view: ProfilViewControllerProtocol!
    var interactor: ProfilInteractorProtocol!
    var router: ProfilRouterProtocol!
    
    
    required init(view:  ProfilViewControllerProtocol) {
          self.view = view
    }
    
    func getData() {
        interactor.getData()
    }
    
    func onLogout() {
        interactor.onLogout()
    }
    
    func onRefresh() {
        interactor.onRefresh()
    }
    
    func startProgress() {
        self.view.startProgress()
    }
    
    func endProgress() {
        self.view.endProgress()
    }
    
    func showAlert(message: String) {
        self.view.showMessage(message: message)
    }
    
    func answerLogout(auth: Bool) {
        if !auth {
            self.router.showAuthScene()
        }       
    }
        
    func answerRefresh(auth: Bool, user: UserTable?) {
        if !auth {
            self.router.showAuthScene()
            return
        }
        
        guard let user = user else {
            return
        }
        
        self.view.setData(user:user)
    }
    
    
    func answerData(user: UserTable?) {
        guard let user = user else {
            self.router.showAuthScene()
            return
        }
        self.view.setData(user:user)
    }
    
}
