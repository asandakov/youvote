//
//  FactoryNetworkCore.swift
//  Flowers
//
//  Created by Алексей on 25.12.2020.
//

import Foundation

import Foundation

enum TypeNetworkCore{
    case Alamofire
}

class FactoryNetworkCore {
    
    static public let defaultFactory = FactoryNetworkCore()
    
    public func createNetwork (typeNetworkCore:TypeNetworkCore = .Alamofire) -> NetworkCoreProtocol{
                
        switch typeNetworkCore {
        case .Alamofire:
            return NetworkCoreAlamofire.default
        }
        
    }
    
    
}
