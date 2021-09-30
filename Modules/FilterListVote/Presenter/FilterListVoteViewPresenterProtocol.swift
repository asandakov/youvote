//
//  FilterListVoteViewPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

protocol FilterListVoteViewPresenterProtocol: class {
    func getParamFilter()
    func setCurTopic(idTopic:Int)
    func getCurTopic()
}
