//
//  MessageCollectionViewCell.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 11.09.2023.
//

import UIKit

class fastGarageCollectionViewCell: UICollectionViewCell {
    let garageView = fastGarageView()
    var sections : [UIView] = []
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(garageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupCell() {
        
        for _ in 0...12 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
            view.layer.cornerRadius = 20
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.white.cgColor
            addSubview(view)
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 40),
                view.heightAnchor.constraint(equalToConstant: 40),
            ])
            
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 33
            
            NSLayoutConstraint.activate([
                stackView.widthAnchor.constraint(equalToConstant: 390),
                stackView.heightAnchor.constraint(equalToConstant: 104),
            ])
            
        }
      
    }
}
