//
//  ListVotePresenter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class ListVotePresenter: ListVoteViewPresenterProtocol, ListVoteInteractorPresenterProtocol {
     
    
    weak var view: ListVoteViewControllerProtocol!
    var interactor: ListVoteInteractorProtocol!
    var router: ListVoteRouterProtocol!
    var isShowFilterListVoteScene:Bool = false
    
    required init(view:  ListVoteViewControllerProtocol) {
          self.view = view
    }
    
    func getCurTopic() {
        if let topic = interactor.getCurTopic() {
            self.view.setCurTopic(topic: topic)
        }
    }
    
    func getVote(page: Int, isPage: Bool, filter: [String : String], search: String) {
        interactor.getVote(page:page, isPage:isPage, filter:filter, search:search)
    }
    
    func answerVote(voteData: VoteResponce) {
        self.view.setData(voteData: voteData)
    }
    
    func onVoteDetail(vote:Vote) {
        let idVote = Int(vote.id) ?? 0
        self.router.showDetailVoteScene(idVote: idVote)
    }
    
    func pageOpenFilter() {
        isShowFilterListVoteScene = self.router.showFilterListVoteScene()
    }
    
    func isPrevShowFilterListVoteScene() {
        if (isShowFilterListVoteScene){
            self.getCurTopic()
            self.view.resetVotePage()            
        }
        isShowFilterListVoteScene = false
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
