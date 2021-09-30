//
//  DetailVoteViewPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol DetailVoteViewPresenterProtocol: class {
    func getVote()
    func sendPoll(idVariant:Int)
}
