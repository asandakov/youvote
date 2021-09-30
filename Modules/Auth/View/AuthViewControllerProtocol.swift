//
//  AuthViewControllerProtocol.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation


protocol AuthViewControllerProtocol: class {
    func startProgress()
    func endProgress()
    func showMessage(message: String)    
    func setShowEmailAuthView(isHidden: Bool)
    func setShowCodelAuthView(isHidden: Bool)
    func setTimerCode(time: Int)
    func stopTimerCode()
    func cancelPublisher()
}
