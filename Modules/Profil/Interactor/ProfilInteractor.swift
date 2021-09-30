//
//  ProfilInteractor.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import Foundation

class ProfilInteractor: ProfilInteractorProtocol {
    weak var presenter: ProfilInteractorPresenterProtocol!
    
    
    let factoryNetwork: FactoryNetworkServiceProtocol = FactoryNetworkService()
    let factoryDb: FactoryDbStorageServiceProtocol = FactoryDbStorageService()
    
    required init(presenter:  ProfilInteractorPresenterProtocol) {
        self.presenter = presenter
    }
       
    
    private func removeDb() {
        let _ =  self.factoryDb.getUserDbStorageService().removeAll()
        let _ = self.factoryDb.getTokenDbStorageService().removeAll()
    }
    
    func onLogout() -> () {
                     
      
        presenter.startProgress()
      
        factoryNetwork.getUserNetworkService().getLogout(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.presenter.endProgress()
               
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let logoutResponce = try? decoder.decode(LogoutResponce.self, from: jsonData)
                                    else {
                                  
                                    self.presenter.showAlert(message: Localization.Network.errorJson)
                         
                                      return
                                   }
                                                        
                            self.removeDb()
                            self.presenter.answerLogout(auth: logoutResponce.auth)
                                                        
                          
                        case  .failure(let error):
                                                    
                            
                            let (error,code)  = error.errorDescription
                            
                            if  let codeMsg  = code{
                                
                                let elementsCode = ["token_refresh"]
                                if elementsCode.contains(codeMsg) {
                                     self.removeDb()
                                     self.presenter.answerLogout(auth: false)
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.presenter.showAlert(message: errorMsg)
                           }
                            
                    }               

            }
        
    }
    
    
    
    
     func onRefresh() -> () {
               
         
         presenter.startProgress()
        
         factoryNetwork.getUserNetworkService().getUser(params: [:]) { [weak self] result in
                                     
                    guard let self = self else { return }
              
                    self.presenter.endProgress()
           
                     switch result {
                                    
                         case  .success(let data):
                             let decoder: JSONDecoder = JSONDecoder()
                                 guard
                                     let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                     let userResponce = try? decoder.decode(UserResponce.self, from: jsonData)
                                     else {
                                             self.presenter.showAlert(message: Localization.Network.errorJson)
                                       return
                                    }
                           
                            
                             let userDb = UserTable()
                             if let user = userResponce.user {
                                 userDb.id = 1
                                 userDb.fio = user.fio
                                 userDb.login = user.login
                                 let _ = self.factoryDb.getUserDbStorageService().update(user: userDb)
                             }
                              
                        self.presenter.answerRefresh(auth: true, user: userDb)
                
                           
                         case  .failure(let error):
                             let (error,code)  = error.errorDescription
                            
                             if  let codeMsg  = code{
                                
                                 let elementsCode = ["token_access", "info_user_1"]
                                 if elementsCode.contains(codeMsg) {
                                    self.removeDb()
                                    self.presenter.answerRefresh(auth: false, user: nil)
                                  
                                     return
                                 }
                                
                             }
                             
                             if let errorMsg  = error{
                                self.presenter.showAlert(message: errorMsg)
                             }
                             
                     }
                 

             }
         
     
         
           }
    
    
    func getData() {      
        if let user =  self.factoryDb.getUserDbStorageService().user(){
            self.presenter.answerData(user: user)
        }else{
            self.presenter.answerData(user: nil)
        }
        
       
        
    }
}
