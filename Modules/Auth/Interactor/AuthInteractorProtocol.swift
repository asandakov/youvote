//
//  AuthInteractorProtocol.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation


protocol AuthInteractorProtocol {
    func sendEmail(email:String)
    func sendCode(email:String, code:String)
}
