//
//  DetailVoteInteractorProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation


protocol DetailVoteInteractorProtocol {
    func getVote(idVote:Int) -> ()
    func pollVote(idVote:Int, idVariant:Int) -> ()
}
