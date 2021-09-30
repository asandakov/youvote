//
//  DetailVotePresenter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class DetailVotePresenter: DetailVoteViewPresenterProtocol, DetailVoteInteractorPresenterProtocol {
          
    weak var view: DetailVoteViewControllerProtocol!
    var interactor: DetailVoteInteractorProtocol!
    var router: DetailVoteRouterProtocol!
    var idVote = 0
    
    required init(view:DetailVoteViewControllerProtocol, idVote:Int) {
          self.view = view
          self.idVote = idVote
    }
    
    func getVote(){
        self.interactor.getVote(idVote: self.idVote)
    }
    
    func sendPoll(idVariant:Int) {
        
        if idVariant > 0 {
            self.interactor.pollVote(idVote: self.idVote, idVariant:idVariant)
        }else{
            self.view.showMessage(message: Localization.DetailVote.errorNoVaraiant)
        }
        
    }
        
    func answerPollVote(success: Bool) {
        if success {
            self.interactor.getVote(idVote: self.idVote)
        }else{
            self.view.showMessage(message: Localization.Error.support)
        }
    }
    
    func answerVote(vote: Vote) {
        self.view.setVote(vote: vote)
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
