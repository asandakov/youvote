//
//  AuthRouter.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import UIKit

class AuthRouter: AuthRouterProtocol {
    weak var view: AuthViewController?
    
    init(viewController: AuthViewController) {
         self.view = viewController
    }
    
    func showProfilScene() {        
        let profilConfigurator = ProfilModuleConfigurator()
        guard let moduleProfil = profilConfigurator.configure() else {return}
        guard let profilViewController = moduleProfil.toPresent() else { return}
        profilViewController.tabBarItem = UITabBarItem(title: Localization.Profil.titleTab, image: Images.TabBar.profil, selectedImage: nil)
        
        guard let navigationController = self.view?.navigationController else { return}
        navigationController.setViewControllers([profilViewController], animated: false)    
    }
    
    deinit {
        print("deinits: "+String(describing: self))
    }
}
