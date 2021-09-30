//
//  CodeAuthView.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import UIKit

class CodeAuthView: UIView, UITextFieldDelegate {
  
        
    let nameLabel: UILabel = {
       let name = UILabel()
       name.numberOfLines = 0
       name.font = Fonts.Text.textSemiboldFont(size: 12.0)
       name.text = Localization.Auth.textCode     
       name.textColor = Colors.Common.grayColor
       name.textAlignment = .center  
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
        
    
    let passwordTextField: UITextField = {
       let password = UITextField()
       password.frame.size = CGSize(width: 230, height: 40)
       password.borderStyle = .roundedRect
       password.placeholder = Localization.Auth.code
       password.isSecureTextEntry = true
       password.translatesAutoresizingMaskIntoConstraints = false
       return password
    }()
    
    let sendBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 230, height: 40)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.Auth.sendCode, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.backgroundEnabled
        send.layer.cornerRadius = 5
        send.isEnabled = false
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    let sendPrevBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 230, height: 40)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.Auth.prevCode, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.background
        send.layer.cornerRadius = 5
        send.isHidden = true
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    
    let timeLabel: UILabel = {
       let time = UILabel()
        time.numberOfLines = 0
        time.font = Fonts.Text.textSemiboldFont(size: 12.0)
        time.text = Localization.Auth.timeCode
        time.textColor = Colors.Common.grayColor
        time.textAlignment = .center
        time.translatesAutoresizingMaskIntoConstraints = false
       return time
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
        addSubview(passwordTextField)
        addSubview(timeLabel)
        addSubview(sendBotton)
        addSubview(sendPrevBotton)
        passwordTextField.delegate = self
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setConstraints() {


        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: passwordTextField.frame.width).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: passwordTextField.frame.height).isActive = true
        
        
        timeLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        sendBotton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sendBotton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        sendBotton.widthAnchor.constraint(equalToConstant: sendBotton.frame.width).isActive = true
        sendBotton.heightAnchor.constraint(equalToConstant: sendBotton.frame.height).isActive = true
        
        
        sendPrevBotton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sendPrevBotton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        sendPrevBotton.widthAnchor.constraint(equalToConstant: sendPrevBotton.frame.width).isActive = true
        sendPrevBotton.heightAnchor.constraint(equalToConstant: sendPrevBotton.frame.height).isActive = true
        
        
    

    }

}
