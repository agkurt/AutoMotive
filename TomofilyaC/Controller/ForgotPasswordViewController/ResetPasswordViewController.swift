//
//  ResetPasswordViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.08.2023.
//

// ResetPasswordViewController.swift
import UIKit

class ResetPasswordViewController: UIViewController {
    
    let resetPasswordView = ResetPasswordView() 
    var email: String?
    var code: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resetPasswordView)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        resetPasswordView.changePasswordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        resetPasswordView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        resetPasswordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            resetPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resetPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func changePasswordTapped() {
        guard let newPassword = resetPasswordView.newPasswordField.text,
              let confirmNewPassword = resetPasswordView.confirmNewPasswordField.text,
              !newPassword.isEmpty, !confirmNewPassword.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen şifreleri giriniz.")
            return
        }
        
        if newPassword != confirmNewPassword {
            showAlert(title: "Hata", message: "Şifreler eşleşmiyor.")
            return
        }
        
        let changePasswordRequest = UserNetworkServiceRoute.passwordReset(email: email!, code: code!, password: newPassword)
        Network.send(request: changePasswordRequest) { (result :Result<PasswordResetResponse , Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Başarılı \(response)")
                    let vc = LoginViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Başarısız \(error)")
            }
        }
    }
    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


