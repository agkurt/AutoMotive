//
//  LoginScreenViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 9.08.2023.
//

import UIKit
import GoogleSignIn

class LoginViewController : UIViewController, LoginScreenViewDelegate , UITextViewDelegate {
    
    var userCredentials : UserCredentials!
    var loginScreenView = LoginScreenView()
    let socialLogin = SocialLoginController()
    
    var isAgreed = false
    let contractText: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    let links = [
        LinkModel(text: "Üyelik Sözleşmesi", url: URL(string: "https://example.com/uyelikSozlesmesi")!),
        LinkModel(text: "Kişisel Veriler ile İlgili Aydınlatma Metni", url: URL(string: "https://example.com/kisiselVeriler")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        navigationItem.hidesBackButton = true
        
        loginScreenView.configureContractText(contractText, with: links)
        view.addSubview(contractText)
        contractText.delegate = self
        
        loginScreenView = LoginScreenView(frame: view.bounds)
        loginScreenView.delegate = self
        view.addSubview(loginScreenView)
        
        loginScreenView.loginButton2.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginScreenView.passwordTitleButton.addTarget(self, action: #selector(handlePasswordTitleButon), for: .touchUpInside)
        loginScreenView.loginSegmentedControl.selectedSegmentIndex = 0
        loginScreenView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginScreenView.agreementButton.addTarget(self, action: #selector(handleAgreementTab), for: .touchUpInside)
        loginScreenView.gmailLoginButton.addTarget(self, action: #selector(handleGoogleLoginButton), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        guard
            let email = loginScreenView.emailTextField2.text ,
            let password = loginScreenView.passwordTextField2.text,
            !email.isEmpty,
            !password.isEmpty else {
            print("Tüm alanları doldurunuz")
            return
        }
        login(email: email, password: password)
        
    }
    private func login(email : String , password: String) {
        let loginRequest = UserNetworkServiceRoute.login(email: email, password: password)
        Network.send(request: loginRequest) { ( result : Result<LoginResponseModel , Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Başarılı \(response)")
                    let vc = TabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    let alert = UIAlertController(title: "OK", message: "Başarılı" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert , animated: true , completion: nil)
                }
            case .failure(let error):
                print("Başarısız \(error)")
            }
        }
    }
    
    @objc func handleAgreementTab() {
        isAgreed.toggle() // true
        if isAgreed {
            let checkmark = UIImage(named: "done")
            loginScreenView.agreementButton.setImage(checkmark, for: .normal)
            loginScreenView.agreementButton.tintColor = .white
            loginScreenView.agreementButton.backgroundColor = .white
        } else {
            let cleanMark = UIImage(named:"clean")
            loginScreenView.agreementButton.setImage(cleanMark, for: .normal)
            loginScreenView.agreementButton.backgroundColor = .white
        }
    }
    
    @objc func signUpButtonTapped() {
        print("Kayıt ol butonuna tıklandı")
        guard
            let fullName = loginScreenView.nameTextField.text ,
            let email = loginScreenView.emailTextField.text ,
            let password = loginScreenView.passwordTextField.text,
            !fullName.isEmpty,
            !email.isEmpty,
            !password.isEmpty
        else {
            print("Tüm alanları doldurunuz")
            return
        }
        register(fullName: fullName, email: email, password: password)
    }
    
    private func sendVerificationCode(email : String) {
        let sendVerificationRequest = UserNetworkServiceRoute.sendVerificationCode(email: email)
        Network.send(request: sendVerificationRequest) { (result : Result<SendVerificationResponse, Error> ) in
            switch result {
            case .success(let response) :
                DispatchQueue.main.async {
                    print("Mail gönderme başarılı : \(response)")
                }
            case .failure(let error) :
                print("Mail gönderme başarısız : \(error)")
                
            }
            
        }
    }
    func register(fullName: String, email: String, password: String) {
        let registerRequest = UserNetworkServiceRoute.register(fullName: fullName, email: email, password: password)
        Network.send(request: registerRequest) { (result : Result< RegisterResponseModel , Error> )in
            switch result {
            case .success(let response) :
                DispatchQueue.main.async {
                    print("Başarılı! Yanıt : \(response)")
                    self.sendVerificationCode(email: email)
                    let vc = VerificationViewController(email: email)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Hata :\(error.localizedDescription)")
            }
        }
    }

    @objc func handleGoogleLoginButton() {
        socialLogin.handleGoogleLoginButton()
    }
    
    @objc func handleLoginButton() {
        print("Giriş Yap butonuna tıklandı.")
    }
    
    @objc func handlePasswordTitleButon() {
        let forgotPasswordVC = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        loginScreenView.updateUIForSelectedSegment()
    }
    @objc func togglePasswordVisibility() {
        let lgnView = loginScreenView
        lgnView.passwordTextField.isSecureTextEntry = !lgnView.passwordTextField.isSecureTextEntry
        let imageName = lgnView.passwordTextField.isSecureTextEntry ? "showIcon" : "visible"
        lgnView.showHideButton.setImage(UIImage(named: imageName), for: .normal)
    }
}





