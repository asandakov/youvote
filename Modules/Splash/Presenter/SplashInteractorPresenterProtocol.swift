//
//  SplashInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

protocol SplashInteractorPresenterProtocol: class {
    func isAuth(auth: Bool)
    func showAlert(message: String)
}
