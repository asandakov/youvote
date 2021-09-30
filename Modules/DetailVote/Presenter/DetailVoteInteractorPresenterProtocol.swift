//
//  DetailVoteInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol DetailVoteInteractorPresenterProtocol: class {
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func answerVote(vote: Vote)
    func answerPollVote(success: Bool)
}
