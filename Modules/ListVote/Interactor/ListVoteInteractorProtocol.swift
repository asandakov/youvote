//
//  ListVoteInteractorProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation


protocol ListVoteInteractorProtocol {
    func getCurTopic() -> TopicTable?
    func getVote(page:Int, isPage:Bool, filter:[String:String], search:String) -> ()
}
