//
//  ResetPasswordView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.08.2023.
//

import UIKit

class ResetPasswordView : UIView {
    let changePasswordButton = UIButton()
    let cancelButton = UIButton()
    let newPasswordField = UITextField()
    let confirmNewPasswordField = UITextField()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        configureButton(changePasswordButton, title: "Parolayı Değiştir", backgroundColor: UIColor.white, textColor: UIColor.black, size: 14)
        configureButton(cancelButton, title: "Vazgeç", backgroundColor: UIColor.clear, textColor: UIColor.white, size:12)
        configureTextField(newPasswordField, placeholder: "Yeni Parola", cornerRadius: 20)
        configureTextField(confirmNewPasswordField, placeholder: "Tekrar Yeni Parola", cornerRadius: 20)
        configureLabel(titleLabel, text: "Parola Sıfırlama", hex: UIColor.white, name: "Poppins", size: 12, aligment: .center)
        configureImage(imageView)
        
        changePasswordButton.anchor(top: topAnchor,bottom: nil,width: 304,height: 40,paddingTop: 409)
        cancelButton.anchor(top: topAnchor,bottom: nil,width: 80,height: 17,paddingTop: 465)
        newPasswordField.anchor(top: topAnchor,bottom: nil,width: 342,height: 44,paddingTop: 265)
        confirmNewPasswordField.anchor(top: topAnchor,bottom: nil,width: 342,height: 44,paddingTop: 325)
        imageView.anchor(top: topAnchor,bottom: nil,width: 121.93,height: 120,paddingTop: 105)
        titleLabel.anchor(top: topAnchor,bottom: nil,width: 120,height: 17,paddingTop: 57)
   
        
        
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
    func configureTextField(_ textField: UITextField, placeholder: String, cornerRadius: CGFloat) {
      
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
       
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        textField.autocorrectionType = .no
        addSubview(textField)
    }
    func configureImage(_ image : UIImageView) {
        image.image = UIImage(named: "password")
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
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
}
