//
//  SocialLoginController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 26.09.2023.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import GoogleSignInSwift

class SocialLoginController : UIViewController {
    
    var lgnView : LoginScreenView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
    }
    
    
    func handleGoogleLoginButton() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                // ...
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
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
    
}
