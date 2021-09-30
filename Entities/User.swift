//
//  User.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

class User:Codable {
    var fio = ""
    var login = ""
    
    enum CodingKeys:String, CodingKey {
        case fio = "FIO"
        case login = "LOGIN"
    }
}


class UserResponce:Codable {
    var user:User?
    
    enum CodingKeys:String, CodingKey {
        case user = "USER"
    }
}
