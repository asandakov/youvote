//
//  SplashInteractor.swift
//  YouVote
//
//  Created by Алексей on 28.05.2021.
//

import Foundation

class SplashInteractor: SplashInteractorProtocol {
    weak var presenter: SplashInteractorPresenterProtocol!
    
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    let factoryDb: FactoryDbStorageServiceProtocol = FactoryDbStorageService()
     
    
    required init(presenter: SplashInteractorPresenterProtocol) {
        self.presenter = presenter

    }
           
    private func removeDb() {
        let _ =  self.factoryDb.getUserDbStorageService().removeAll()
        let _ = self.factoryDb.getTokenDbStorageService().removeAll()
    }
    
    func onLogon() -> () {
        
        factoryNetwork.getUserNetworkService().getUser(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }

            
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let _ = try? decoder.decode(UserResponce.self, from: jsonData)
                                    else {
                             
                                    self.presenter.showAlert(message:Localization.Network.errorJson)
                                                            
                                    
                                      return
                                   }
                          
                            
                         self.presenter.isAuth(auth: true)
           
                            
                          
                        case  .failure(let error):
                            let (error,code)  = error.errorDescription
                           
                            if  let codeMsg = code{
                               
                                let elementsCode = ["token_access", "info_user_1"]
                                if elementsCode.contains(codeMsg) {
                                    self.getTokenUser()
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.presenter.showAlert(message:errorMsg)
                            }
                            
                    }
                

            }
        
    
        
          }
    
    
    func getTokenUser() -> () {
                
          
        factoryNetwork.getUserNetworkService().getToken(params: [:]) { [weak self] result in
                                    
                  guard let self = self else { return }
                    
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let token = try? decoder.decode(Token.self, from: jsonData)
                                    else {
                                    
                                    self.presenter.showAlert(message:Localization.Network.errorJson)
                     
                                      return
                                   }
                            
                                                   
                        
                                let tokenDb = TokenTable()
                                tokenDb.id = 1
                                tokenDb.access = token.access
                                tokenDb.refresh = token.refresh
                                tokenDb.timeAssess = token.timeAssess
                            
                                if token.access != "" {
                                    let _ = self.factoryDb.getTokenDbStorageService().update(token: tokenDb)
                                   
                                    self.presenter.isAuth(auth: true)
                                                    
                                    return
                                }
                            
                           
                            self.presenter.isAuth(auth: false)
                            self.removeDb()
                          
                        case  .failure(let error):
                           
                            let (_,_)  = error.errorDescription
                            self.presenter.isAuth(auth: false)
                            self.removeDb()
                            
                    }
                

            }
        
        
    }


    deinit {
        print("deinit: "+String(describing: self))
    }
    
}
