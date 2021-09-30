//
//  FeedbackInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol FeedbackInteractorPresenterProtocol: class {
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func answerSendFeedback(send: Bool)
}
