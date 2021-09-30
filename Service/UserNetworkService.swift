//
//  Auth.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation


protocol UserNetworkServiceProtocol {
    func getUser(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func sendCodeAuth(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    
    func sendEmailAuth(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    
    
    func getLogout(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getToken(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
}


class UserNetworkService: UserNetworkServiceProtocol {
    
    static public let defaultFactory = UserNetworkService()
      
    func getUser(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
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
        request.url = Settings.apiURL+ApiMethods.userInfo.rawValue
        request.method = .GET

        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
         
            
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
    func getToken(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        var tokenRefresh = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenRefresh = tokenInfo.refresh
        }
           
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenRefresh
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.userToken.rawValue
        request.method = .GET
    
     
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }
    
    
    func sendCodeAuth(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
        
        var tokenFb = ""
        if let tokenInfo = FbTokenDbStorageService.defaultFactory.token() {
            tokenFb = tokenInfo.token
        }
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "fbToken" : tokenFb
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.userSendCode.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }
    
    
    func sendEmailAuth(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.userSendEmail.rawValue
        request.method = .GET
        
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }
    
    
    func getLogout(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
         
        var tokenRefresh = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenRefresh = tokenInfo.refresh
        }
        
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenRefresh
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.userLogout.rawValue
        request.method = .GET

    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
     
    }
    
}
