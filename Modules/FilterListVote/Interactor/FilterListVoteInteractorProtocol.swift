//
//  FilterListVoteInteractorProtocol.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation


protocol FilterListVoteInteractorProtocol {
    func getParamFilter() -> ()
    func setCurTopic(idTopic:Int)
    func getCurTopic() -> TopicTable?
}
