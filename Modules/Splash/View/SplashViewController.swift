//
//  SplashViewController.swift
//  YouVote
//
//  Created by Алексей on 28.05.2021.
//

import UIKit

class SplashViewController: UIViewController, SplashViewControllerProtocol {

    var presenter: SplashViewPresenterProtocol!
   
    
    let logoImage: UIImageView = {
       let img = UIImageView(image:Images.Splash.logo)
       img.frame.size = CGSize(width: 150, height: 150)
       img.translatesAutoresizingMaskIntoConstraints = false
       return img
    }()
    
    let nameLabel: UILabel = {
       let name = UILabel()
       name.font = Fonts.Text.textSemiboldFont(size: 24.0)
       name.text = Localization.Splash.name
       name.numberOfLines = 1
       name.textColor = Colors.Splash.name
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(logoImage)
        view.addSubview(nameLabel)
        view.addSubview(indicatorView)
       
        setConstraints()
        presenter.start()        
        
    }
    
    
    func showMessage(message: String) {
       self.showAlert(message: message)
    }
    
    
    
    
    
    private func setConstraints() {
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: logoImage.frame.size.width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: logoImage.frame.size.height).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
                
    }
    
    
    deinit {
        print("deinit: "+String(describing: self))
    }
}
