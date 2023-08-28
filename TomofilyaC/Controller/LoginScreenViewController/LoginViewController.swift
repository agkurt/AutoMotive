//
//  LoginScreenViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 9.08.2023.
//

import UIKit
import GoogleSignIn

class LoginViewController : UIViewController, LoginScreenViewDelegate , UITextViewDelegate  {
    
    
    var userCredentials : UserCredentials!
    var loginScreenView = LoginScreenView()
    
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
        
        
        
        loginScreenView.configureContractText(contractText, with: links)
        view.addSubview(contractText)
        contractText.delegate = self
        
        view.backgroundColor = UIColor.black
        loginScreenView = LoginScreenView(frame: view.bounds)
        loginScreenView.delegate = self
        view.addSubview(loginScreenView)
        
        loginScreenView.loginButton2.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginScreenView.appleLoginButton.addTarget(self, action: #selector(handleAppleLoginButton), for: .touchUpInside)
        loginScreenView.gmailLoginButton.addTarget(self, action: #selector(handleGoogleLoginButton), for: .touchUpInside)
        loginScreenView.passwordTitleButton.addTarget(self, action: #selector(handlePasswordTitleButon), for: .touchUpInside)
        loginScreenView.loginSegmentedControl.selectedSegmentIndex = 0
        loginScreenView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        
    }
    
    @objc func loginButtonTapped() {
      
        let email = loginScreenView.emailTextField2.text
        let password = loginScreenView.passwordTextField2.text
        guard let emailUnwrapped = email, !emailUnwrapped.isEmpty,
              let passwordUnwrapped = password, !passwordUnwrapped.isEmpty else {
           
            print("Lütfen tüm alanları doldurunuz.")
            return
        }
        
        let credentials = ["email": emailUnwrapped, "password": passwordUnwrapped]
        
        AuthService.shared.login(credentials: credentials) { (success, messageOrToken) in
            DispatchQueue.main.async {
                if success {
                    let homeVc = HomeController()
                    self.navigationController?.pushViewController(homeVc, animated: true)
                    print("Başarılı giriş! Token: \(messageOrToken ?? "N/A")")
                } else {
                    // Hatalı giriş işlemi sonrası işlemler
                    print("Giriş başarısız! Hata: \(messageOrToken ?? "Bilinmeyen hata")")
                }
            }
        }
    }
    
    @objc func signUpButtonTapped() {
        print("Kayıt ol butonuna tıklandı.")
        
        print("name: \(loginScreenView.nameTextField.text ?? "nil")")
        print("email: \(loginScreenView.emailTextField.text ?? "nil")")
        print("password: \(loginScreenView.passwordTextField.text ?? "nil")")
        
        
        let name = loginScreenView.nameTextField.text
        let email = loginScreenView.emailTextField.text
        let password = loginScreenView.passwordTextField.text
       
        guard let usernameUnwrapped = name , !usernameUnwrapped.isEmpty,
              let emailUnwrapped = email , !emailUnwrapped.isEmpty,
              let passwordUnwrapped = password , !passwordUnwrapped.isEmpty else {
            
            print("Lütfen tüm alanları doldurunuz.")
            return
        }
        
        // API'ye gönderilecek bilgilerin hazırlanması
        let credentials = ["fullName" : usernameUnwrapped , "email" : emailUnwrapped , "password" : passwordUnwrapped]
        
        
        // Kayıt olma işleminin gerçekleştirilmesi
        AuthService.shared.register(userDetails: credentials) { (success, messageOrToken) in
            DispatchQueue.main.async {
                if success {
                    // Başarılı kayıt işlemi sonrası işlemler
                    print("Başarılı kayıt! Token: \(messageOrToken ?? "N/A")")
                    let mailVerifyVC = MailVerifyViewController(email: email ?? "")
                    self.navigationController?.pushViewController(mailVerifyVC, animated: true)
                    
                } else {
                    // Hatalı kayıt işlemi sonrası işlemler
                    print("Kayıt başarısız! Hata: \(messageOrToken ?? "Bilinmeyen hata")")
                }
            }
        }
    }
    
    @objc func handleLoginButton() {
        
        print("Giriş Yap butonuna tıklandı.")
        
    }
    
    
    @objc func handleAppleLoginButton() {
        print("Apple ile Giriş Yap butonuna tıklandı.")
        
    }
    @objc func handleGoogleLoginButton() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Google Sign-In hata: \(error!.localizedDescription)")
                return
            }
            
            guard let signInResult = signInResult else {
                print("No sign-in result present")
                return
            }
            
            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else {
                    print("Failed to refresh tokens: \(error!.localizedDescription)")
                    return
                }
                
                guard let user = user else {
                    print("No user present after token refresh")
                    return
                }
                
                if let idTokenValue = user.idToken {
                    let idTokenString = idTokenValue.tokenString // Bu satırı ekledim.
                    AuthService.shared.socialLogin(token: idTokenString, platform: .Google) { (success, messageOrToken, isSocialMediaAccount) in
                        DispatchQueue.main.async {
                            if success {
                                if isSocialMediaAccount {
                                    print("Successfully logged in with Gmail! It's a social media account. Token: \(messageOrToken ?? "N/A")")
                                    let homeVc = HomeController()
                                    self.navigationController?.pushViewController(homeVc, animated: true)
                                } else {
                                    print("Successfully logged in with Gmail! Token: \(messageOrToken ?? "N/A")")
                                }
                            } else {
                                print("Failed to login with Gmail. Error: \(messageOrToken ?? "Unknown error")")
                            }
                        }
                    }
                } else {
                    print("Failed to obtain idToken")
                }
            }
        }
    }
    
    
    @objc func handlePasswordTitleButon() {
        let forgotPasswordVC = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        loginScreenView.updateUIForSelectedSegment()
    }
}
