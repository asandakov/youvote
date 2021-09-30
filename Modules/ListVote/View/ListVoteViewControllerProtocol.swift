//
//  ListVoteViewControllerProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation


protocol ListVoteViewControllerProtocol: class {
    func startProgress()
    func endProgress()
    func showMessage(message: String)
    func setCurTopic(topic: TopicTable)
    func setData(voteData: VoteResponce)
    func resetVotePage()
}
