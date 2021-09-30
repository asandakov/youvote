//
//  FeedbackViewPresenterProtocol.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol FeedbackViewPresenterProtocol: class {
    func sendFeedback(name:String, email:String, text:String)
}
