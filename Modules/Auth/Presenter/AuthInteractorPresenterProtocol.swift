//
//  AuthInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

protocol AuthInteractorPresenterProtocol: class {
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func answerSendEmail(send: Bool, time:Int)
    func answerSendCode(send: Bool)
}
