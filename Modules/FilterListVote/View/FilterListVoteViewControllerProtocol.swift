//
//  FilterListVoteViewControllerProtocol.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation


protocol FilterListVoteViewControllerProtocol: class {
   
    func startProgress()
    func endProgress()
    func showMessage(message: String)
    func setFilter(topic:[TopicTable])
    func setCurTopic(curTopic: TopicTable?)
}
