//
//  ForgotPasswordViewController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 18.08.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    let forgotPasswordView = ForgotPasswordView()

    override func viewDidLoad() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        view.addSubview(forgotPasswordView)

        forgotPasswordView.sendButton.addTarget(self, action: #selector(self.fargotPasswordTap), for: .touchUpInside)
        forgotPasswordView.cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped), for: .touchUpInside)
        forgotPasswordView.emailField.addTarget(self, action: #selector(self.configureEmailField), for: .editingChanged)

        forgotPasswordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordView.topAnchor.constraint(equalTo: view.topAnchor),
            forgotPasswordView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            forgotPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forgotPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func fargotPasswordTap() {
        guard let email = forgotPasswordView.emailField.text,
                !email.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen geçerli bir e-posta giriniz.")
            return
        }
        let passwordRequest = UserNetworkServiceRoute.sendVerificationCode(email: email)
        Network.send(request: passwordRequest) {(result : Result<SendVerificationResponse , Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    let vc = VerificationViewController(email: email)
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("Başarılı \(response)")
                }
            case .failure(let error):
                print("Başarısız \(error)")
            }
        }
    }

    @objc private func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }


    @objc private func configureEmailField() {    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


