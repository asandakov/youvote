//
//  AuthInteractor.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

class AuthInteractor: AuthInteractorProtocol {
     
    weak var presenter: AuthInteractorPresenterProtocol!
    
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    let factoryDb: FactoryDbStorageServiceProtocol = FactoryDbStorageService()
    
    required init(presenter:  AuthInteractorPresenterProtocol) {
        self.presenter = presenter

    }
      
    func sendEmail(email:String) -> () {
                     
        let params = [
            "login": email.lowercased()
        ]
        
        presenter.startProgress()
      
        factoryNetwork.getUserNetworkService().sendEmailAuth(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.presenter.endProgress()
               
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let sendEmailAuthResponce = try? decoder.decode(SendEmailAuthResponce.self, from: jsonData)
                                    else {
                                  
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                         
                                      return
                                   }
                            
                            
                            self.presenter.answerSendEmail(send: sendEmailAuthResponce.send, time:sendEmailAuthResponce.time)
                           
                         
                          
                        case  .failure(let error):
                            
                            
                            let (error,_)  = error.errorDescription
                            
                            if let errorMsg = error{
                                
                                self.presenter.showAlert(message: errorMsg)
                          
                            
                            }
                            
                    }
                

            }
        
    }
    
    
    func sendCode(email:String, code:String) -> () {
                     
        let params = [
            "login": email.lowercased(),
            "password": code.lowercased()
        ]

        presenter.startProgress()
        
        factoryNetwork.getUserNetworkService().sendCodeAuth(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.presenter.endProgress()
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let sendCodeAuthResponce = try? decoder.decode(SendCodeAuthResponce.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                                   
                                      return
                                   }
                            
                 
                            if let token = sendCodeAuthResponce.token {
                               
                                let tokenDb = TokenTable()
                                tokenDb.id = 1
                                tokenDb.access = token.access
                                tokenDb.refresh = token.refresh
                                tokenDb.timeAssess = token.timeAssess
                                
                                let _ = self.factoryDb.getTokenDbStorageService().update(token: tokenDb)
                            }
                            
                            if let user = sendCodeAuthResponce.user {
                                
                                let userDb = UserTable()
                                userDb.id = 1
                                userDb.fio = user.fio
                                userDb.login = user.login
                                let _ = self.factoryDb.getUserDbStorageService().update(user: userDb)
                            }
                                                        
                            
                            self.presenter.answerSendCode(send: true)
                    
                          
                        case  .failure(let error):
                            
                            
                            let (error,_)  = error.errorDescription
                            
                            if let errorMsg = error{
                                self.presenter.showAlert(message: errorMsg)
                            }
                            
                    }
                

            }
        
    }
    
    deinit {
        print("deinits: "+String(describing: self))
    }
    
}
