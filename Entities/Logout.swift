//
//  Logout.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

class LogoutResponce:Codable {
    var auth:Bool = false
    
    enum CodingKeys:String, CodingKey {
        case auth = "AUTH"
    }
}
