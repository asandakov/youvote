//
//  ProfilInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol ProfilInteractorPresenterProtocol: class {
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func answerLogout(auth: Bool)
    func answerRefresh(auth: Bool, user: UserTable?)
    func answerData(user: UserTable?)
}
