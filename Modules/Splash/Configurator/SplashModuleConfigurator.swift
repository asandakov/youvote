//
//  SplashModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 28.05.2021.
//

import Foundation

class SplashModuleConfigurator: SplashModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = SplashViewController();
        
            let presenter = SplashPresenter(view: viewController)
            let interactor = SplashInteractor(presenter: presenter)
            let router = SplashRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router
       
        
            return viewController
        }
    
    
    deinit {
        print("deinit: "+String(describing: self))
    }
}
