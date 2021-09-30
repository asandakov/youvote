//
//  AuthPresenter.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

class AuthPresenter: AuthViewPresenterProtocol, AuthInteractorPresenterProtocol {
  
    
    weak var view: AuthViewControllerProtocol!
    var interactor: AuthInteractorProtocol!
    var router: AuthRouterProtocol!
    
    
    required init(view:  AuthViewControllerProtocol) {
          self.view = view
    }
    
    
    func sendEmail(email: String) {
         interactor.sendEmail(email: email)
    }
    
    
    func answerSendEmail(send: Bool, time: Int) {
        if (send){
            self.view.setTimerCode(time: time)
            self.view.setShowEmailAuthView(isHidden: true)
            self.view.setShowCodelAuthView(isHidden: false)           
        }        
    }
         
    
    func sendCode(email:String, code: String) {
        interactor.sendCode(email: email, code:code)
    }
    
    func answerSendCode(send: Bool) {
        if (send){
            self.view.stopTimerCode()
            self.view.cancelPublisher()
            self.router.showProfilScene()   
        }
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
    
    deinit {
        print("deinits: "+String(describing: self))
    }
}
