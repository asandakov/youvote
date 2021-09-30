//
//  ProfilRouter.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class ProfilRouter: ProfilRouterProtocol {
    weak var view: ProfilViewController?
    
    init(viewController: ProfilViewController) {
         self.view = viewController
    }
    
    
    func showAuthScene() {
        let authConfigurator = AuthModuleConfigurator()
        guard let moduleAuth = authConfigurator.configure() else {return}
        guard let authViewController = moduleAuth.toPresent() else { return}
        authViewController.tabBarItem = UITabBarItem(title: Localization.Profil.titleTab, image: Images.TabBar.profil, selectedImage: nil)
        
        guard let navigationController = self.view?.navigationController else { return}
        navigationController.setViewControllers([authViewController], animated: false)
    }
    
}
