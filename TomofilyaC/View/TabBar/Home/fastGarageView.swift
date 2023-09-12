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
     func configureCell(with image :String , title : String) {
        let cellImage = UIImageView()
        cellImage.image = UIImage(named: image)
        cellImage.layer.borderColor = UIColor.white.cgColor
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.layer.cornerRadius = 20
        addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellImage.widthAnchor.constraint(equalToConstant: 40),
            cellImage.heightAnchor.constraint(equalToConstant: 40),
            cellImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
        
        let cellTitle = UILabel()
        cellTitle.font = UIFont(name: "Poppins-Light", size: 6)
        cellTitle.textColor = UIColor.white
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
         cellTitle.text = title
        addSubview(cellTitle)
        
        NSLayoutConstraint.activate([
            cellTitle.widthAnchor.constraint(equalToConstant: 48 ),
            cellTitle.heightAnchor.constraint(equalToConstant: 8 ),
            cellTitle.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8)
        ])
    }
    
}
