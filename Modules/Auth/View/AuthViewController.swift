//
//  AuthViewController.swift
//  YouVote
//
//  Created by Алексей on 29.05.2021.
//

import UIKit
import Combine

class AuthViewController: UIViewController, AuthViewControllerProtocol {
   
    var presenter: AuthViewPresenterProtocol!
    
    var viewEmailAuth = EmailAuthView()
    var viewCodelAuth = CodeAuthView()
    var timer: Timer?
    var timeCode = 0
    var emailFieldCancellable: AnyCancellable?
    var codeFieldCancellable: AnyCancellable?
    
    
    let nameLabel: UILabel = {
       let name = UILabel()
       name.font = Fonts.Text.textSemiboldFont(size: 20.0)
       name.text = Localization.Auth.name
       name.numberOfLines = 1
       name.textColor = Colors.Common.grayColor
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    
    let errorLabel: UILabel = {
        let error = UILabel()
        error.font = Fonts.Text.textSemiboldFont(size: 12.0)
        error.text = " "
        error.numberOfLines = 0
        error.textColor = Colors.Common.readColor
        error.translatesAutoresizingMaskIntoConstraints = false
       return error
    }()

    
    let text: UITextView = {
        let text =  UITextView()
        text.frame.size = CGSize(width: 270, height: 40)
        text.font = Fonts.Text.textSemiboldFont(size: 12.0)
        text.textColor = Colors.Common.grayColor
        text.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: Localization.Auth.text)
        let policyURL = URL(string: Settings.policyURL)!
        attributedString.setAttributes([.link: policyURL], range: NSMakeRange(31, attributedString.length - 31))
        text.attributedText = attributedString
        text.isUserInteractionEnabled = true
        text.linkTextAttributes = [.foregroundColor: Colors.Common.brownColor]
        text.textAlignment = .center
        text.isEditable = false
        text.isScrollEnabled = false

        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        self.navigationItem.title = Localization.Profil.title
              
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       
        view.addSubview(nameLabel)
        view.addSubview(errorLabel)
        view.addSubview(viewEmailAuth)
        view.addSubview(viewCodelAuth)
        view.addSubview(text)
        
    
       emailFieldCancellable = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: viewEmailAuth.loginTextField)
            .map {($0.object as? UITextField)?.text ?? ""}
            .map {
                str -> Bool in
                return (str.replacingOccurrences(of: " ", with: "") != "")
            }
           .sink(
                receiveValue: { value in
                    self.errorLabel.text = " "
                    self.viewEmailAuth.sendBotton.isEnabled = value
                    if (value){
                        self.viewEmailAuth.sendBotton.backgroundColor = Colors.Button.background
                    }else{
                        self.viewEmailAuth.sendBotton.backgroundColor = Colors.Button.backgroundEnabled
                    }
                }
           )


        codeFieldCancellable = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: viewCodelAuth.passwordTextField)
             .map {($0.object as? UITextField)?.text ?? ""}
             .map {$0.replacingOccurrences(of: " ", with: "")}
             .map {
                 str -> Bool in
                 return (str != "")
             }
            .sink(
                 receiveValue: { value in
                     self.viewCodelAuth.sendBotton.isEnabled = value
                     if (value){
                         self.viewCodelAuth.sendBotton.backgroundColor = Colors.Button.background
                     }else{
                         self.viewCodelAuth.sendBotton.backgroundColor = Colors.Button.backgroundEnabled
                     }
                 }
            )

        viewEmailAuth.sendBotton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        viewCodelAuth.sendBotton.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        viewCodelAuth.sendPrevBotton.addTarget(self, action: #selector(sendPrev), for: .touchUpInside)

    
        setConstraints()
    
       
    }
    
    
  

    @objc func sendPrev(){
        errorLabel.text = " "
        viewCodelAuth.passwordTextField.text = ""
        viewEmailAuth.isHidden = false
        viewCodelAuth.isHidden = true
    }
    
    @objc func sendEmail(){

        errorLabel.text = " "
        
        guard  var email = viewEmailAuth.loginTextField.text else{
            return
        }
        
        email = email.replacingOccurrences(of: " ", with: "")
        if (!email.isValidEmail){
           errorLabel.text = Localization.Auth.Error.noEmailAuth
            return
        }
        
        viewCodelAuth.nameLabel.text =  Localization.Auth.textCode.replacingOccurrences(of: "%s", with: email)
        
        viewEmailAuth.endEditing(true)

        presenter.sendEmail(email: email)
  
    }
    
    
    @objc func sendCode(){
    
        errorLabel.text = " "
        
        guard var email = viewEmailAuth.loginTextField.text else{
            return
        }
        guard  let code = viewCodelAuth.passwordTextField.text else{
            return
        }
        
        email = email.replacingOccurrences(of: " ", with: "")
        if (!email.isValidEmail){
           errorLabel.text = Localization.Auth.Error.noEmailAuth
           return
        }
        
        if (code == ""){
           errorLabel.text = Localization.Auth.Error.noEmptyFieldCode
            return
        }
        
        viewCodelAuth.endEditing(true)

        presenter.sendCode(email: email, code:code)
  
    }
    
    func setTimerCode(time: Int) {
        timeCode = time
        viewCodelAuth.timeLabel.text =  Localization.Auth.timeCode.replacingOccurrences(of: "%s", with: "\(timeCode)")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerCode), userInfo: nil, repeats: true)
    }
    func stopTimerCode() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func setShowEmailAuthView(isHidden: Bool) {
        viewEmailAuth.isHidden = isHidden
    }
    
    func setShowCodelAuthView(isHidden: Bool) {
        viewCodelAuth.isHidden = isHidden
        viewCodelAuth.sendBotton.isHidden = false
        viewCodelAuth.sendPrevBotton.isHidden = true
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
    
    
    func cancelPublisher() {
        emailFieldCancellable?.cancel()
        codeFieldCancellable?.cancel()
    }
    
    @objc func onTimerCode() {
       
        timeCode -= 1
        
        viewCodelAuth.timeLabel.text =  Localization.Auth.timeCode.replacingOccurrences(of: "%s", with: "\(timeCode)")
     
        if timeCode <= 0 {
            timer?.invalidate()
            viewCodelAuth.sendBotton.isHidden = true
            viewCodelAuth.sendPrevBotton.isHidden = false
            timer = nil
        }
    }
    
    private func setConstraints() {

        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true


        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        
        viewEmailAuth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewEmailAuth.topAnchor.constraint(equalTo:errorLabel.bottomAnchor, constant: 15).isActive = true
        viewEmailAuth.heightAnchor.constraint(equalToConstant: viewEmailAuth.frame.size.height).isActive = true
        viewEmailAuth.widthAnchor.constraint(equalToConstant: viewEmailAuth.frame.size.width).isActive = true
        
        
        
        viewCodelAuth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewCodelAuth.topAnchor.constraint(equalTo:errorLabel.bottomAnchor, constant: 15).isActive = true
        viewCodelAuth.heightAnchor.constraint(equalToConstant: viewCodelAuth.frame.size.height).isActive = true
        viewCodelAuth.widthAnchor.constraint(equalToConstant: viewCodelAuth.frame.size.width).isActive = true
        
        text.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 175).isActive = true
        text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true


    }
        
    deinit {
        print("deinits: "+String(describing: self))
    }
}
