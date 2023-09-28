//
//  createButtonModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 25.09.2023.
//

import UIKit

let lgnView = LoginScreenView()
let apple = UIImage(named: "apple")
let google = UIImage(named: "google")
let eyeOff = UIImage(named: "eyeOff")

let createButton : (UIButton , CGFloat , String , UIColor , UIColor  ) -> UIButton = {
    button , size , title , textColor , backgroundColor  in
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont(name: "Poppins-Light", size: size)
    button.setTitle(title, for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 20
    button.setTitleColor(textColor, for: .normal)
    button.backgroundColor = backgroundColor
    return button
} // nameTextField.frame.height

let createTextField : (UITextField , String , CGFloat , CGFloat ) -> UITextField = {
    textField , placeholder , cornerRadius , height in
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: height))
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
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
    textField.autocorrectionType = .no
    textField.font = UIFont(name: "Poppins-Regular", size: 12)
    return textField
}

let createSocialLoginButton : (UIButton ,String , UIColor , UIColor , UIImage) -> UIButton = {
    button , title , backgroundColor , textColor , setImage in
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.backgroundColor = backgroundColor
    button.setTitleColor(textColor, for: .normal)
    button.layer.masksToBounds = true
    button.layer.borderWidth = 1.0
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.cornerRadius = 20
    button.clipsToBounds = true
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    button.setImage(setImage, for: .normal)
    return button
    
}
