//
//  VerificationViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 19.08.2023.
//

import UIKit

class VerificationViewController: UIViewController {
    let verificationView = VerificationView()
    let loginScreenView = LoginScreenView()// optinal
    var email : String
    var timer: Timer?
    var remainingSeconds = 1.30
    
    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(verificationView)
        startTimer()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        verificationView.sendButton.addTarget(self, action: #selector(self.sendButtonTapped), for: .touchUpInside)
        
        verificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verificationView.topAnchor.constraint(equalTo: view.topAnchor),
            verificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.backgroundColor = UIColor.black
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingSeconds > 0.00 {
            remainingSeconds -= 0.01
            verificationView.countdownLabel.text = "\((remainingSeconds))"
        } else {
            timer?.invalidate()
        }
    }
    
    @objc func sendButtonTapped() {
        guard let code1 = verificationView.no1.text ,
              let code2 = verificationView.no2.text ,
              let code3 = verificationView.no3.text ,
              let code4 = verificationView.no4.text ,
              !code1.isEmpty,
              !code2.isEmpty,
              !code3.isEmpty,
              !code4.isEmpty else {
            print("Tüm alanları doldurunuz.")
            return
        }
        let fullCode = code1 + code2 + code3 + code4
        
        if fullCode.count != 4 {
            let alert = UIAlertController(title: "Hata", message: "Lütfen 4 haneli doğrulama kodunu girin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let verifyRequest = UserNetworkServiceRoute.verifyCode(email: email, code: fullCode)
        Network.send(request: verifyRequest) { (result :Result<VerifyCodeResponse ,Error> ) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Başarılı \(response)")
                    let vc = ResetPasswordViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Başarısız \(error)")
            }
        }
    }
}

