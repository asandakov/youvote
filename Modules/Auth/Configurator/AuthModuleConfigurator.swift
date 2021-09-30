//
//  AuthModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//


import Foundation

class AuthModuleConfigurator:  AuthModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = AuthViewController();
        
            let presenter = AuthPresenter(view: viewController)
            let interactor = AuthInteractor(presenter: presenter)
            let router = AuthRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
    deinit {
        print("deinits: "+String(describing: self))
    }
}
