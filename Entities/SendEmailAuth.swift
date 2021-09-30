//
//  SendEmail.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

class SendEmailAuthResponce:Codable {
    var send: Bool = false
    var time: Int = 0
    
    enum CodingKeys:String, CodingKey {
        case send = "SEND"
        case time = "TIME"
    }
}
