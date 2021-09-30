//
//  ListVoteRouterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol ListVoteRouterProtocol: class {
    func showDetailVoteScene(idVote:Int)
    func showFilterListVoteScene() -> Bool
}
