//
//  ListVoteInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol ListVoteInteractorPresenterProtocol: class {
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func getCurTopic()
    func answerVote(voteData: VoteResponce)
}
