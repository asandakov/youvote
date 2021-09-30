//
//  VoteNetworkService.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

protocol VoteNetworkServiceProtocol {
    func getList(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getVote(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func pollVote(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getParamFilter(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
   
}


class VoteNetworkService: VoteNetworkServiceProtocol {
    
    static public let defaultFactory = VoteNetworkService()
      
    func getList(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenAccess
        ]
              
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
       
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.listVote.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            
            if (params["page"] != "1"){
                sleep(1)
            }

            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
    
    func getVote(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenAccess
        ]
              
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
       
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.detailVote.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
           
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
  
    
    func pollVote(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenAccess
        ]
       
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.pollVote.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
    
    
    func getParamFilter(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenAccess
        ]
       
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.filterVote.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
}
