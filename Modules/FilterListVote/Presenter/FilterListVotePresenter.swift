//
//  FilterListVotePresenter.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

class FilterListVotePresenter: FilterListVoteViewPresenterProtocol, FilterListVoteInteractorPresenterProtocol {
    
    weak var view: FilterListVoteViewControllerProtocol!
    var interactor: FilterListVoteInteractorProtocol!
    var router: FilterListVoteRouterProtocol!
    
    
    required init(view:  FilterListVoteViewControllerProtocol) {
          self.view = view
    }
   
    func getCurTopic() {
        let topic = interactor.getCurTopic()
        self.view.setCurTopic(curTopic: topic)        
    }
    
    func getParamFilter() {
        interactor.getParamFilter()
    }
    
    func setCurTopic(idTopic:Int){
        interactor.setCurTopic(idTopic:idTopic)
    }
    
    func answerFilter(topic:[TopicTable]) {
        self.view.setFilter(topic: topic)
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
