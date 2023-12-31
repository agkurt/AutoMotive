//
//  LoginScreenView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 9.08.2023.
//
import UIKit
import GoogleSignIn

protocol LoginScreenViewDelegate: AnyObject {
    func handleLoginButton()
    func segmentedControlValueChanged(_ sender: UISegmentedControl)
}

class LoginScreenView: UIView {
    private var signUpProcessStack: UIStackView!
    private var logInProcessStack : UIStackView!
    private var buttonStackView : UIStackView!
    private var agreementStackView : UIStackView!
    private var optionsButtonStackView : UIStackView!
    let apple = UIImage(named: "apple")
    let google = UIImage(named: "google")
    let eyeOff = UIImage(named: "eyeOff")
    var links: [LinkModel] = []
    let passwordTextField = UITextField()
    let passwordTextField2 = UITextField()
    let emailTextField = UITextField()
    let emailTextField2 = UITextField()
    let imageView = UIImageView()
    let forgotPasswordButton = UIButton()
    let loginButton2 = UIButton() //1
    let signUpButton = UIButton()//2
    let passwordTitleButton = UIButton() //3
    let contractText = UITextView()
    let buttonsView = UIView()
    let nameTextField = UITextField()
    let appleLoginButton = UIButton()
    let gmailLoginButton = UIButton()
    var signUpConstraints: [NSLayoutConstraint] = []
    var logInConstraints: [NSLayoutConstraint] = []
    let showHideButton = UIButton(type: .custom)
    let agreementLabel = UILabel()
    let agreementButton = UIButton()

    weak var delegate: LoginScreenViewDelegate?
    
    lazy var loginSegmentedControl: UISegmentedControl = {
        let items = ["Kayıt Ol", "Giriş Yap"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0 // ilk öğeyi varsayılan olarak seçin
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 20
        segmentedControl.clipsToBounds = true
        segmentedControl.selectedSegmentTintColor = .red
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        return segmentedControl
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        configureAllModel()
        configureContractText(contractText, with: links)
        configureAgreement()
        configureStackField()
        configureStackAgreement()
        imageView.anchor(top: topAnchor,bottom: nil,width: 180,height: 140,paddingTop: 45)
        loginSegmentedControl.anchor(top: topAnchor,bottom: nil,width: 240,height: 44,paddingTop: 150)
        loginScreenContraints()
        updateUIForSelectedSegment()
    }
    func configureContractText(_ textView: UITextView, with links: [LinkModel]) {
        let baseText = "Uygulamaya üye olarak; Üyelik Sözleşmesi’ni ve Kişisel Veriler ile İlgili Aydınlatma Metni’ni okuduğunuzu ve kabul ettiğinizi onaylamaktasınız."
        let links = [
            LinkModel(text: "Üyelik Sözleşmesi", url: URL(string: "https://tomofilyastorage.blob.core.windows.net/contracts/Tomofilya_Uyelik_Sozlesmesi.pdf")!),
            LinkModel(text: "Kişisel Veriler ile İlgili Aydınlatma Metni", url: URL(string: "https://tomofilyastorage.blob.core.windows.net/contracts/Tomofilya_KVKK_Aydinlatma_Metni.pdf")!)
        ]

        let attributedString = NSMutableAttributedString(string: baseText)
        for link in links {
            let linkRange = (baseText as NSString).range(of: link.text)
            attributedString.addAttribute(.link, value: link.url, range: linkRange)  // Doğrudan link.url'yi kullanabilirsiniz.
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: linkRange)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkRange)
        }

        textView.attributedText = attributedString
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.red,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        // Diğer özellikleri ayarlama
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Poppins-Light", size: 10)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.textAlignment = .left
        addSubview(textView)
    }
    
    func configureAgreement() {
        agreementLabel.text = "Tomofilya ürün ve hizmetleri ile ilgili ticari elektronik ileti (e-posta ve sms) almak istiyorum."
        agreementLabel.numberOfLines = 0 // Birden fazla satır için
        agreementLabel.font = UIFont(name: "Poppins-Light", size: 10)
        agreementLabel.textColor = UIColor.white
        agreementLabel.backgroundColor = UIColor.clear
        agreementLabel.isUserInteractionEnabled = true
        agreementButton.layer.cornerRadius = 12
        agreementButton.layer.borderColor = UIColor.black.cgColor
        agreementButton.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            agreementButton.widthAnchor.constraint(equalToConstant: 24),
            agreementButton.heightAnchor.constraint(equalToConstant: 24)
        ])

    }
    
    func configureStackAgreement() {
        agreementStackView = UIStackView(arrangedSubviews: [agreementButton, agreementLabel])
        agreementStackView.axis = .horizontal
        agreementStackView.spacing = 5
        agreementStackView.alignment = .center
        agreementStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(agreementStackView)
    }
    
    func configureLabel(_ label:UILabel ,text : String  , textAligment : NSTextAlignment , name :String , size : CGFloat) {
        label.text = text
        label.textAlignment = textAligment
        label.font = UIFont(name: name, size: size)
    }
    
    @objc func handleLoginButton() {
        self.delegate?.handleLoginButton()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(sender)
    }
    
    func updateUIForSelectedSegment() {
        if loginSegmentedControl.selectedSegmentIndex == 0 {  // Kayıt Ol
            signUpProcessStack.isHidden = false
            logInProcessStack.isHidden = true
            loginButton2.isHidden = true   
            passwordTitleButton.isHidden = true
            signUpButton.isHidden = false
            contractText.isHidden = false
            showHideButton.isHidden = false
            agreementStackView.isHidden = false
           
            NSLayoutConstraint.deactivate(logInConstraints)
            NSLayoutConstraint.activate(signUpConstraints)
        } else {  // Giriş Yap
            signUpProcessStack.isHidden = true
            logInProcessStack.isHidden = false
            loginButton2.isHidden = false
            passwordTitleButton.isHidden = false
            signUpButton.isHidden = true
            showHideButton.isHidden = false
            agreementStackView.isHidden = true
            
            NSLayoutConstraint.deactivate(signUpConstraints)
            NSLayoutConstraint.activate(logInConstraints)
        }
        layoutIfNeeded()
    }
    
    func createStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat, distribution: UIStackView.Distribution = .fillEqually, cornerRadius: CGFloat = 0, backgroundColorHex: String? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if let hex = backgroundColorHex {
            stackView.backgroundColor = UIColor(hex: hex)
        }

        stackView.layer.cornerRadius = cornerRadius

        return stackView
    }
    
    func configureStackField() {
        signUpProcessStack = createStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField], spacing: 16)
        addSubview(signUpProcessStack)
        
        optionsButtonStackView = createStackView(arrangedSubviews: [appleLoginButton, gmailLoginButton], spacing: 16, cornerRadius: 20, backgroundColorHex: "#0F0F0F")
        addSubview(optionsButtonStackView)
        
        addSubview(loginSegmentedControl)
        
        logInProcessStack = createStackView(arrangedSubviews: [emailTextField2 , passwordTextField2], spacing: 16)
        addSubview(logInProcessStack)
    }
    
    private func configureAllModel() {
        let loginButton2 = createButton(loginButton2, 14, "Giriş Yap", UIColor.black, UIColor.white)
        addSubview(loginButton2)
        let signUpButton = createButton(signUpButton, 14, "Kayıt Ol", UIColor.black, UIColor.white)
        addSubview(signUpButton)
        let passwordTitleButton = createButton(passwordTitleButton, 12, "Parolanı mı unuttun?", UIColor.white, UIColor.clear)
        addSubview(passwordTitleButton)
        let emailTextField = createTextField(emailTextField , "Email" , 20 , nameTextField.frame.height )
        addSubview(emailTextField)
        let passwordTextField = createTextField(passwordTextField , "Şifre" , 20  ,nameTextField.frame.height)
        addSubview(passwordTextField)
        let nameTextField = createTextField(nameTextField , "Ad-Soyad" ,20 , nameTextField.frame.height )
        addSubview(nameTextField)
        let passwordTextField2 = createTextField(passwordTextField2 , "Şifre" , 20 , nameTextField.frame.height )
        addSubview(passwordTextField2)
        let emailTextField2 = createTextField(emailTextField2 , "Email" , 20 ,nameTextField.frame.height )
        addSubview(emailTextField2)
        let appleLoginButton = createSocialLoginButton(appleLoginButton , "Apple ile Devam Et" , UIColor(hex:"#0F0F0F") , UIColor.white , apple!)
        addSubview(appleLoginButton)
        let gmailLoginButton = createSocialLoginButton(gmailLoginButton , "Google ile Devam Et" , UIColor(hex:"#0F0F0F") , UIColor.white , google!)
        addSubview(gmailLoginButton)
        
        showHideButton.setImage(UIImage(named: "eyeOff"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.layer.cornerRadius = 20
        addSubview(showHideButton)
        
        passwordTextField.rightView = showHideButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        addSubview(imageView)

    }
    
    private func loginScreenContraints() {
        signUpConstraints = [ 
            
            agreementStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            agreementStackView.widthAnchor.constraint(equalToConstant: 356),
            agreementStackView.heightAnchor.constraint(equalToConstant: 32),
            agreementStackView.topAnchor.constraint(equalTo:contractText.bottomAnchor, constant: 16),
            
            signUpButton.widthAnchor.constraint(equalToConstant: 304),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 441.71),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                    
            signUpProcessStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpProcessStack.heightAnchor.constraint(equalToConstant: 164),
            signUpProcessStack.widthAnchor.constraint(equalToConstant: 342),
            signUpProcessStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 65),
            
            optionsButtonStackView.widthAnchor.constraint(equalToConstant: 342),
            optionsButtonStackView.heightAnchor.constraint(equalToConstant: 104),
            optionsButtonStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 55),
            optionsButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            contractText.widthAnchor.constraint(equalToConstant: 354),
            contractText.heightAnchor.constraint(equalToConstant: 60),
            contractText.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            contractText.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ]
        
        logInConstraints = [
            
            logInProcessStack.widthAnchor.constraint(equalToConstant: 342),
            logInProcessStack.heightAnchor.constraint(equalToConstant: 104),
            logInProcessStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            logInProcessStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            optionsButtonStackView.widthAnchor.constraint(equalToConstant: 342),
            optionsButtonStackView.heightAnchor.constraint(equalToConstant: 104),
            optionsButtonStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 478.71),
            optionsButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginButton2.widthAnchor.constraint(equalToConstant: 304),
            loginButton2.heightAnchor.constraint(equalToConstant: 40),
            loginButton2.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 293.71),
            loginButton2.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            passwordTitleButton.widthAnchor.constraint(equalToConstant: 170),
            passwordTitleButton.heightAnchor.constraint(equalToConstant: 17),
            passwordTitleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTitleButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 260.71),
            
        ]
    }

}
