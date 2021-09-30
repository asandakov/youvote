//
//  ProfilViewController.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class ProfilViewController: UIViewController, ProfilViewControllerProtocol {

    var presenter: ProfilViewPresenterProtocol!
    
    let homeScroll = UIScrollView()
   
     let titleLabel: UILabel = {
        let title = UILabel()
        title.font = Fonts.Text.textSemiboldFont(size: 12.0)
        title.text = Localization.Profil.emailParam
        title.numberOfLines = 1
        title.textColor = Colors.Param.title
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
     }()
     
     let emailLabel: UILabel = {
        let email = UILabel()
        email.font = Fonts.Text.textSemiboldFont(size: 16.0)
        email.numberOfLines = 1
        email.text = Localization.Profil.emailNameParam
        email.textColor = Colors.Param.name
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Localization.Profil.title
        
        let exitItem = UIBarButtonItem(image: Images.Profil.exit, style: .plain, target: self, action: #selector(exitApp))
     
        self.navigationItem.rightBarButtonItems = [exitItem]
        
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        homeScroll.refreshControl = UIRefreshControl()
        homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)
        
        homeScroll.isScrollEnabled = true
        homeScroll.showsVerticalScrollIndicator = true
        homeScroll.showsHorizontalScrollIndicator = false
    
      
        view.addSubview(homeScroll)
        homeScroll.addSubview(titleLabel)
        homeScroll.addSubview(emailLabel)
            
        setConstraints()
        
        self.presenter.getData()

    }
        
    @objc func exitApp(){
       
        self.showAlert(tite: Localization.Alert.Profil.title, message: Localization.Alert.Profil.message,  okButton: Localization.Alert.Profil.okButton, handlerOkButton: { ()  in
            
            self.presenter.onLogout()
            
        },canselButton: Localization.Alert.canselButton)
    }
    
    
    @objc func refreshHome(sendrer:UIRefreshControl){        
        self.presenter.onRefresh()
        homeScroll.refreshControl?.endRefreshing()
    }
    
    
    func setData(user:UserTable) {
        emailLabel.text = user.login
    }
    
    func showMessage(message: String) {
       self.showAlert(message: message)
    }
    
    
    func startProgress() {
        self.showProgressHUD()
    }
    
    func endProgress() {
        self.hideProgressHUD()
    }

    
    
    private func setConstraints() {
    
        homeScroll.translatesAutoresizingMaskIntoConstraints = false
        homeScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        homeScroll.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
      
        homeScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        homeScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
      
      
      titleLabel.leadingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.leadingAnchor, constant: 10).isActive = true
      titleLabel.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 20).isActive = true
      
      
        emailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
       
 

    }
}
