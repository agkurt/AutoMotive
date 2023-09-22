//
//  MessageCollectionViewCell.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 11.09.2023.
//

import UIKit
import Kingfisher


class fastGarageCollectionViewCell: UICollectionViewCell {

    let cellImage = UIImageView()
    let cellTitle = UILabel()
    private var homeData : HomeData?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        cellImage.layer.borderColor = UIColor.white.cgColor
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.layer.cornerRadius = 20
        addSubview(cellImage)
       
        NSLayoutConstraint.activate([
            cellImage.widthAnchor.constraint(equalToConstant: 40),
            cellImage.heightAnchor.constraint(equalToConstant: 40),
        ])
       
        cellTitle.font = UIFont(name: "Poppins-Light", size: 6)
        cellTitle.textColor = UIColor.white
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellTitle)
       
        NSLayoutConstraint.activate([
            cellTitle.widthAnchor.constraint(equalToConstant: 48),
            cellTitle.heightAnchor.constraint(equalToConstant: 8),
            cellTitle.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8)
        ])
    }
    
    func configureCell(with garage : Garage) {
        let url = URL(string: garage.logoUrl)
        cellImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        cellTitle.text = garage.userName
    }
}
