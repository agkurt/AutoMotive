//
//  SocialLoginController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 26.09.2023.
//

import UIKit
import GoogleSignIn

class SocialLoginController : UIViewController {
    
    var lgnView : LoginScreenView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func handleGoogleLoginButton() {
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
                    let idTokenString = idTokenValue.tokenString
                    let registerRequest = UserNetworkServiceRoute.socialLogin(token: idTokenString, platform: "Google")
                    Network.send(request: registerRequest) {(result : Result<SocialResponseModel , Error>) in
                        switch result {
                        case.success(let response):
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
                }else {
                    print("Failed to obtain idToken")
                }
                
            }
        }
    }
    
    func handleAppleLoginButton() {
        print("Apple ile giriş yapıldı.")
    }
    
    func handleLoginButton() {
        print("Giriş Yap butonuna tıklandı.")
    }
    
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let lgnView = lgnView else {return}
        lgnView.updateUIForSelectedSegment()
    }
    
}


