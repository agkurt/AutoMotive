//
//  ForgotPasswordView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 18.08.2023.
//

import UIKit

class ForgotPasswordView : UIView {
    let imageView = UIImageView()
    let informationLabel = UILabel()
    let mailLabel = UILabel()
    let passwordLabel = UILabel()
    let sendButton = UIButton()
    let cancelButton = UIButton()
    let emailField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        configureImage(imageView)
        configureLabel(informationLabel, text: "Sana parola yenileme linki göndermemiz için mail adresini girmelisin.", hex: UIColor(hex: "#B5B5B5"), name:"Poppins" , size: 10,aligment: .center)
        configureLabel(mailLabel, text: "Mailini Gir", hex: UIColor(hex: "#E42E0E") , name:"Poppins-Light" , size: 12 , aligment: .center)
        configureLabel(passwordLabel, text: "Parolamı Unuttum", hex: UIColor.white, name:"Poppins" , size: 12 ,aligment: .center)
        configureButton(sendButton, title: "Gönder", backgroundColor: UIColor.white, textColor: UIColor.black, size: 14)
        configureButton(cancelButton, title: "Vazgeç", backgroundColor: UIColor.clear, textColor: UIColor.white, size: 12)
        configureTextField(emailField, placeholder:"Email", cornerRadius: 20)
        anchors()
        
        
        
    }
    func configureLabel(_ label :UILabel ,text : String , hex : UIColor , name : String , size :CGFloat , aligment : NSTextAlignment) {
        label.text = text
        label.textColor = hex
        label.textAlignment = aligment
        label.numberOfLines = 0
        label.font = UIFont(name: name, size: size )
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

    }
    
    func configureButton(_ button: UIButton, title: String, backgroundColor: UIColor, textColor: UIColor , size : CGFloat ) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "Poppins-Light", size: size)
        addSubview(button)
    }
    
    func configureImage(_ image : UIImageView) {
        image.image = UIImage(named: "letter")
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
    }
    
    func configureTextField(_ textField: UITextField, placeholder: String, cornerRadius: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: emailField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.placeholder = "\t\(placeholder)"
        textField.layer.cornerRadius = cornerRadius
        textField.layer.borderWidth = 0.6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.white
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        textField.autocorrectionType = .no
        addSubview(textField)
    }
    private func anchors() {
        imageView.anchor(top: topAnchor,bottom: nil,width: 160,height: 105.37,paddingTop: 121.67)
        sendButton.anchor(top: topAnchor , bottom:nil , width: 304 , height: 40 , paddingTop: 426)
        informationLabel.anchor(top: topAnchor , bottom:nil , width: 326 , height: 60 , paddingTop: 274)
        mailLabel.anchor(top: topAnchor , bottom:nil , width: 80, height: 30 , paddingTop: 241)
        cancelButton.anchor(top: topAnchor , bottom:nil , width: 150, height: 17 , paddingTop: 482)
        passwordLabel.anchor(top: topAnchor , bottom:nil , width: 150, height: 30 , paddingTop: 57)
        emailField.anchor(top: topAnchor , bottom:nil , width: 304, height: 44 , paddingTop: 342)
    }
}
