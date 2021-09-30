//
//  ListVoteViewPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol ListVoteViewPresenterProtocol: class {
    func getVote(page: Int, isPage: Bool, filter: [String : String], search: String)
    func onVoteDetail(vote:Vote)
    func pageOpenFilter()
    func getCurTopic()
    func isPrevShowFilterListVoteScene()
}
