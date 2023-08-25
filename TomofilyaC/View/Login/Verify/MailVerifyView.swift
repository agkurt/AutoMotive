//
//  MailVerifyView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.08.2023.
//

import UIKit

class MailVerifyView : UIView , UITextFieldDelegate{
    let no1 = UITextField()
    let no2 = UITextField()
    let no3 = UITextField()
    let no4 = UITextField()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let checkMailLabel = UILabel()
    let mailInformationLabel = UILabel()
    let sendButton = UIButton()
    var fieldStackView = UIStackView()
    let countdownLabel = UILabel()
    let againSendButton = UIButton()
    let againSendLabel = UILabel()
    var sendStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        configureImage(imageView)
        
        configureTextField(no1, cornerRadius: 20)
        configureTextField(no2, cornerRadius: 20)
        configureTextField(no3, cornerRadius: 20)
        configureTextField(no4, cornerRadius: 20)
        
        no1.delegate = self
        no2.delegate = self
        no3.delegate = self
        no4.delegate = self
        
        configureLabel(titleLabel, text: "Mail Doğrulama", hex: UIColor.white, name: "Poppins-Light", size: 12, aligment: .center)
        configureLabel(checkMailLabel, text: "Mailini Kontrol Et", hex: UIColor.red, name: "Poppins-Light", size: 12, aligment: .center)
        configureLabel(mailInformationLabel , text: "Mail adresine gönderdiğimiz 4 haneli kodu girmelisin", hex: UIColor.white, name: "Poppins-Light", size: 10, aligment: .center)
        configureCountdownLabel(countdownLabel)
        configureButton(sendButton, title: "Gönder", backgroundColor: UIColor.white, textColor: UIColor.black, size: 14)
        configureButton(againSendButton, title: "Yeniden Gönder", backgroundColor: UIColor.clear, textColor: UIColor.red, size: 12)
        configureLabel(againSendLabel, text: "Kodu almadın mı?", hex: UIColor.white, name: "Poppins-Light", size: 12, aligment: .center)
        
        
        fieldStackView = UIStackView(arrangedSubviews: [no1, no2, no3, no4])
        sendStackView = UIStackView(arrangedSubviews: [againSendLabel , againSendButton])
        configureStackView(fieldStackView , distribution: .fillEqually , spacing: 12)
        configureStackView(sendStackView, distribution: .fill , spacing: 6)
        sendStackView.anchor(top: topAnchor,bottom: nil,width: 221,height: 17,paddingTop: 497)
        fieldStackView.anchor(top: topAnchor,bottom: nil,width: 212,height: 54,paddingTop: 314)
        imageView.anchor(top: topAnchor,bottom: nil,width: 160,height: 114.19,paddingTop: 102.81)
        checkMailLabel.anchor(top: topAnchor,bottom: nil,width: 96,height: 17,paddingTop: 241)
        mailInformationLabel.anchor(top: topAnchor,bottom: nil,width: 274,height: 15,paddingTop: 270)
        countdownLabel.anchor(top:topAnchor, bottom: nil, width:60, height: 17, paddingTop: 384)
        sendButton.anchor(top:topAnchor, bottom: nil, width:304, height: 40, paddingTop: 441)
        titleLabel.anchor(top:topAnchor, bottom: nil, width:96, height: 17, paddingTop: 60)
        
        
        
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
    func configureTextField(_ textField: UITextField, cornerRadius: CGFloat) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = cornerRadius
        textField.layer.borderWidth = 0.6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.systemGray
        textField.textColor = UIColor.red
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        textField.autocorrectionType = .no
        addSubview(textField)
    }
    func configureStackView(_ stackView : UIStackView , distribution : UIStackView.Distribution , spacing: CGFloat ) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = distribution
        addSubview(stackView)
    }
    
    func textFieldConstraint() {
        NSLayoutConstraint.activate([
            no1.widthAnchor.constraint(equalToConstant: 44),
            no2.widthAnchor.constraint(equalToConstant: 44),
            no3.widthAnchor.constraint(equalToConstant: 44),
            no4.widthAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    func configureImage(_ image : UIImageView) {
        image.image = UIImage(named: "sendemail")
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
    }
    
    func configureCountdownLabel(_ label: UILabel) {
        label.text = "00:60"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Light", size: 14)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, (text.count + string.count - range.length) > 0 {
            textField.backgroundColor = .white
        } else {
            textField.backgroundColor = .systemGray
        }
        return true
    }
}
