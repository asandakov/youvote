//
//  ProfilModuleConfigurator.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//


import Foundation

class ProfilModuleConfigurator:  ProfilModuleConfiguratorProtocol {
    
    public func configure() -> Presentable?  {
        
            let viewController = ProfilViewController();
        
            let presenter = ProfilPresenter(view: viewController)
            let interactor = ProfilInteractor(presenter: presenter)
            let router = ProfilRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router       
        
            return viewController
        }
    
}
