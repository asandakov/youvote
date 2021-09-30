//
//  Logon.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation


class SendCodeAuthResponce:Codable {
    var user:User?
    var token:Token?
    
    enum CodingKeys:String, CodingKey {
        case user = "USER"
        case token = "TOKEN"
    }
}
