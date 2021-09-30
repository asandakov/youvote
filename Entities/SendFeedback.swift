//
//  SendFeedback.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class SendFeedbackResponce:Codable {
    var send: Bool = false

    
    enum CodingKeys:String, CodingKey {
        case send = "SEND"
    }
}
