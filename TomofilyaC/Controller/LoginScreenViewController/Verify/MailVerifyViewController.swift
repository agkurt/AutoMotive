//
//  MailVerifyViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.08.2023.
//

import UIKit

class MailVerifyViewController : UIViewController {
    let mailVerifyVC = MailVerifyView()
    var email: String
    var timer: Timer?
    var remainingSeconds = 1.30
    
    
    
    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        
        mailVerifyVC.sendButton.addTarget(self, action: #selector(self.sendButtonTapped), for: .touchUpInside)
        
        view.addSubview(mailVerifyVC)
        mailVerifyVC.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mailVerifyVC.topAnchor.constraint(equalTo: view.topAnchor),
            mailVerifyVC.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mailVerifyVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mailVerifyVC.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
            mailVerifyVC.countdownLabel.text = "\((remainingSeconds))" 
           
        } else {
            timer?.invalidate()
            
        }
    }
    
    @objc func sendButtonTapped() {
        let code1 = mailVerifyVC.no1.text ?? ""
        let code2 = mailVerifyVC.no2.text ?? ""
        let code3 = mailVerifyVC.no3.text ?? ""
        let code4 = mailVerifyVC.no4.text ?? ""
        
        let fullCode = code1 + code2 + code3 + code4
        
        if fullCode.count != 4 {
         
            let alert = UIAlertController(title: "Hata", message: "Lütfen 4 haneli doğrulama kodunu girin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        AuthService.shared.verify(email: email, code: fullCode) { (success, errorMessage) in
            DispatchQueue.main.async {
                if success {
                    // Doğrulama başarılıysa
                    let resetPasswordVC = ResetPasswordViewController(email: self.email, code: fullCode)
                    self.navigationController?.pushViewController(resetPasswordVC, animated: true)
                } else {
                    
                    // Doğrulama başarısızsa
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
