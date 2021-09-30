//
//  SplashRouter.swift
//  YouVote
//
//  Created by Алексей on 28.05.2021.
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    weak var view: SplashViewController?
    
    init(viewController: SplashViewController) {
         self.view = viewController
    }
    
     
    func showMainScene(auth:Bool) {
        
        guard let rootController = SceneDelegate.shared?.window?.rootViewController else { return }
        guard let rootViewController = rootController as? UINavigationController else { return }
        
                
        let tabController = UITabBarController()
        tabController.tabBar.tintColor = Colors.Common.brownColor
          
                
        var profilView = UIViewController()
        if (auth) {
            let profilConfigurator = ProfilModuleConfigurator()
            guard let moduleProfil = profilConfigurator.configure() else {return}
            guard let profilViewController = moduleProfil.toPresent() else { return }
            profilView = profilViewController
        }else{
            let authConfigurator = AuthModuleConfigurator()
            guard let moduleAuth = authConfigurator.configure() else {return}
            guard let authViewController = moduleAuth.toPresent() else { return }
            profilView = authViewController
        }
    
     
        profilView.tabBarItem = UITabBarItem(title: Localization.Profil.titleTab, image: Images.TabBar.profil, selectedImage: nil)
        
        let ProfilNavController = UINavigationController()
        ProfilNavController.navigationBar.tintColor = Colors.Common.brownColor
        
        ProfilNavController.setViewControllers([profilView], animated: true)

        
        
        let feedbackConfigurator = FeedbackModuleConfigurator()
        guard let moduleFeedback = feedbackConfigurator.configure() else {return}
        guard let feedbackViewController = moduleFeedback.toPresent() else { return }
        
        feedbackViewController.tabBarItem = UITabBarItem(title: Localization.Feedback.titleTab, image: Images.TabBar.feedback, selectedImage: nil)

        let FeedbackNavController = UINavigationController()
        FeedbackNavController.navigationBar.tintColor = Colors.Common.brownColor
        FeedbackNavController.viewControllers = [feedbackViewController]
        
        
        let ListVoteConfigurator = ListVoteModuleConfigurator()
        guard let moduleListVote = ListVoteConfigurator.configure() else {return}
        guard let ListVoteViewController = moduleListVote.toPresent() else { return }
        
        ListVoteViewController.tabBarItem = UITabBarItem(title: Localization.ListVote.titleTab, image: Images.TabBar.list, selectedImage: nil)
        
        let ListVoteNavController = UINavigationController()
        ListVoteNavController.navigationBar.tintColor = Colors.Common.brownColor
        ListVoteNavController.viewControllers = [ListVoteViewController]
        
        
        tabController.setViewControllers([ListVoteNavController, FeedbackNavController, ProfilNavController], animated: true)
        
        

        rootViewController.setViewControllers([tabController], animated: false)
        rootViewController.isNavigationBarHidden = true
    }
    
    deinit {
        print("deinit: "+String(describing: self))
    }
}
