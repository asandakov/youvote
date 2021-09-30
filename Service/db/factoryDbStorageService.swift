//
//  factoryDBStorage.swift
//  YouVote
//
//  Created by Алексей on 31.05.2021.
//

import Foundation

protocol FactoryDbStorageServiceProtocol {
    func getTokenDbStorageService() -> TokenDbStorageServiceProtocol
    func getUserDbStorageService() -> UserDbStorageServiceProtocol
    func getTopicDbStorageService() -> TopicDbStorageServiceProtocol
    func getFbTokenDbStorageService() -> FbTokenDbStorageServiceProtocol
}

class FactoryDbStorageService: FactoryDbStorageServiceProtocol {
    
    func getTokenDbStorageService() -> TokenDbStorageServiceProtocol{
        return TokenDbStorageService.defaultFactory
    }
    
    func getUserDbStorageService() -> UserDbStorageServiceProtocol{
        return UserDbStorageService.defaultFactory
    }
    
    func getTopicDbStorageService() -> TopicDbStorageServiceProtocol{
        return TopicDbStorageService.defaultFactory
    }
    
    func getFbTokenDbStorageService() -> FbTokenDbStorageServiceProtocol{
        return FbTokenDbStorageService.defaultFactory
    }
}
