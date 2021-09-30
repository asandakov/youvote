//
//  FeedbackNetworkService.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation


protocol FeedbackNetworkServiceProtocol {
    func sendFeedback(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
}


class FeedbackNetworkService: FeedbackNetworkServiceProtocol {
    
    static public let defaultFactory = FeedbackNetworkService()

        
    func sendFeedback(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.sendFeedback.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }
       
}
