//
//  CategoryView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 11.09.2023.
//

import UIKit

class fastGarageView : UIView {
    private let titleLabel = UILabel()
    private let homeView = HomeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
       configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "En Hızlı Garajlar"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Poppins-Regular", size: 12)
        titleLabel.textColor = UIColor.init(hex:"#B5B5B5")
        titleLabel.textAlignment = .left
        titleLabel.isUserInteractionEnabled = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 91),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
           
        ])
    }
}
