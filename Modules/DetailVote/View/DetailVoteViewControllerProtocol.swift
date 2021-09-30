//
//  DetailVoteViewControllerProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation


protocol DetailVoteViewControllerProtocol: class {
    func startProgress()
    func endProgress()
    func showMessage(message: String)
    func setVote(vote: Vote)
}
