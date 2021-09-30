//
//  FilterListVoteInteractorPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

protocol FilterListVoteInteractorPresenterProtocol: class {  
    func startProgress()
    func endProgress()
    func showAlert(message: String)
    func answerFilter(topic:[TopicTable])
    func getCurTopic()
}
