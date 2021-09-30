//
//  EmailView.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import UIKit

class EmailAuthView: UIView, UITextFieldDelegate {
  
        
    let nameLabel: UILabel = {
       let name = UILabel()
       name.numberOfLines = 0
       name.font = Fonts.Text.textSemiboldFont(size: 12.0)
       name.text = Localization.Auth.textEmail
       name.textColor = Colors.Common.grayColor
       name.textAlignment = .center      
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
      
  
    let loginTextField: UITextField = {
       let login = UITextField()
       login.frame.size = CGSize(width: 230, height: 40)
       login.borderStyle = .roundedRect
        login.placeholder = Localization.Auth.email
       login.translatesAutoresizingMaskIntoConstraints = false
       return login
    }()
    
    
    let sendBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 230, height: 40)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.Auth.sendEmail, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.backgroundEnabled
        send.layer.cornerRadius = 5
        send.isEnabled = false
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    
    override init(frame: CGRect) {
        let screenSize: CGRect = UIScreen.main.bounds
        super.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 180))
        decorate()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func decorate() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(nameLabel)
        addSubview(loginTextField)
        addSubview(sendBotton)
        translatesAutoresizingMaskIntoConstraints = false
        loginTextField.delegate = self
        setConstraints()

    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setConstraints() {
        
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true

        
        loginTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: loginTextField.frame.width).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: loginTextField.frame.height).isActive = true
 
        
        
        sendBotton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sendBotton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15).isActive = true
        sendBotton.widthAnchor.constraint(equalToConstant: sendBotton.frame.width).isActive = true
        sendBotton.heightAnchor.constraint(equalToConstant: sendBotton.frame.height).isActive = true

    }

}
