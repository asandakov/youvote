//
//  Vote.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

struct Vote:Codable {
    var id = ""
    var question = ""
    var startDate = ""
    var endDate = ""
    var countVote = 0
    var urlTelegram = ""
    var urlInst = ""
    var variant:[Variant] = []
    
    enum CodingKeys:String, CodingKey {
        case id = "ID"
        case question = "QUESTION"
        case startDate = "DATE_START"
        case endDate = "DATE_END"
        case countVote = "COUNT_VOTE"
        case variant = "VARIANT"
        case urlTelegram = "URL_TELEGRAM"
        case urlInst = "URL_INST"
    }
       
}

struct Variant:Codable {
    var id = ""
    var name = ""
    var percent = 0
    var icon = Images.App.notChecked
 
    enum CodingKeys:String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case percent = "PERCENT"
    }
}


struct VoteResponce:Codable {
    var votes:[Vote] = []
    var count:Int = 0
    var isPage:Bool = false
    var allPage:Int = 0
   
    
    enum CodingKeys:String, CodingKey {
        case votes = "LIST"
        case count = "COUNT"
        case allPage = "ALL_PAGE"
        case isPage = "FLAG_NAV"
    }
}


struct VoteDeatailResponce:Codable {
    var vote:Vote?
    
    enum CodingKeys:String, CodingKey {
        case vote = "VOTE"
    }
}


struct PollVoteResponce:Codable {
    var success = false
    
    enum CodingKeys:String, CodingKey {
        case success = "SUCCESS"
    }
}



struct Topic:Codable {
    var id = ""
    var code = ""
    var name = ""
    var level = ""
    
    enum CodingKeys:String, CodingKey {
        case id = "ID"
        case code = "CODE"
        case name = "NAME"
        case level = "LEVEL"
    }
       
}


struct FilterParamVoteResponce:Codable {
    var topic:[Topic] = []
    
    enum CodingKeys:String, CodingKey {
        case topic = "TOPIC"
    }
}
