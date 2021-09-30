//
//  ApiMethods.swift
//  YouVote
//
//  Created by Алексей on 12.05.2021.
//

import Foundation


enum ApiMethods: String {
    case userInfo = "/user.getUser/"
    case userSendEmail = "/user.sendEmail/"
    case userSendCode = "/user.getAuth/"
    case userLogout = "/user.getLogout/"
    case userToken = "/token.getGeneratorRefresh/"
    case sendFeedback = "/feedback.sendFeedback/"
    case listVote = "/vote.getList/"
    case detailVote = "/vote.getVote/"
    case pollVote = "/vote.pollVote/"
    case filterVote = "/vote.getParamFilter/"
}
