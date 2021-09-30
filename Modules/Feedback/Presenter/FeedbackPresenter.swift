//
//  FeedbackPresenter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class FeedbackPresenter: FeedbackViewPresenterProtocol, FeedbackInteractorPresenterProtocol {
    
    weak var view: FeedbackViewControllerProtocol!
    var interactor: FeedbackInteractorProtocol!
    var router: FeedbackRouterProtocol!
    
    
    required init(view:  FeedbackViewControllerProtocol) {
          self.view = view
    }
        
    func sendFeedback(name:String, email:String, text:String) {
        interactor.sendFeedback(name: name, email: email, text: text)
    }
    
    func answerSendFeedback(send: Bool) {
        if send {
            self.view.clear()
            self.view.showMessage(message: Localization.Feedback.success)
        }else{
            self.view.showMessage(message: Localization.Feedback.error)
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
}
