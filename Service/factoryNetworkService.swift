//
//  factoryNetworkService.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

protocol FactoryNetworkServiceProtocol {
    func getUserNetworkService() -> UserNetworkServiceProtocol
    func getFeedbackNetworkService() -> FeedbackNetworkServiceProtocol
    func getVoteNetworkService() -> VoteNetworkServiceProtocol
}

class FactoryNetworkService: FactoryNetworkServiceProtocol {
    
    func getUserNetworkService() -> UserNetworkServiceProtocol{
        return UserNetworkService.defaultFactory
    }    
   
    func getFeedbackNetworkService() -> FeedbackNetworkServiceProtocol{
        return FeedbackNetworkService.defaultFactory
    }
    
    func getVoteNetworkService() -> VoteNetworkServiceProtocol{
        return VoteNetworkService.defaultFactory
    }
}
