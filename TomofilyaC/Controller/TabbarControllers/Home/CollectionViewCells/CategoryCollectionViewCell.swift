//
//  CategoryCollectionViewCell.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 7.09.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var sections: [UIView] = []
    private var categoryLabel = UILabel()
    let homeView = HomeView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureLabel(categoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        for _ in 0..<6 {
            let sectionView = UIView()
            sectionView.translatesAutoresizingMaskIntoConstraints = false
            sectionView.backgroundColor = .black
            sectionView.layer.borderColor = UIColor.white.cgColor
            sectionView.layer.borderWidth = 0.5
            sectionView.layer.cornerRadius = 20
            contentView.addSubview(sectionView)
            sections.append(sectionView)
            
        }
        
        for i in 0..<3 {
            NSLayoutConstraint.activate([
                sections[i].topAnchor.constraint(equalTo: contentView.topAnchor),
                sections[i].leadingAnchor.constraint(equalTo: i == 0 ? contentView.leadingAnchor : sections[i-1].trailingAnchor, constant: 13),
                sections[i].widthAnchor.constraint(equalToConstant: 108),
                sections[i].heightAnchor.constraint(equalToConstant: 80),
            ])
        }
        
        for i in 3..<6 {
            NSLayoutConstraint.activate([
                sections[i].topAnchor.constraint(equalTo: sections[0].bottomAnchor, constant: 13),
                sections[i].leadingAnchor.constraint(equalTo: i == 3 ? contentView.leadingAnchor : sections[i-1].trailingAnchor, constant: 13),
                sections[i].widthAnchor.constraint(equalToConstant: 108),
                sections[i].heightAnchor.constraint(equalToConstant: 80)
            ])
        }
    }
    
    func configureCell(with categories: [CategoryItem]) {
        for (index, category) in categories.enumerated() {
            let label = UILabel()
            label.text = category.title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: category.image)
            imageView.contentMode = .scaleAspectFit
            let section = sections[index]
            
            section.subviews.forEach { $0.removeFromSuperview() }
            
            let innerStackView = UIStackView(arrangedSubviews: [imageView, label])
            innerStackView.axis = .vertical
            innerStackView.spacing = 5
            innerStackView.translatesAutoresizingMaskIntoConstraints = false
            section.addSubview(innerStackView)
          
            NSLayoutConstraint.activate([
                innerStackView.centerXAnchor.constraint(equalTo: section.centerXAnchor),
                innerStackView.centerYAnchor.constraint(equalTo: section.centerYAnchor)
            ])
        }
    }
    func configureLabel(_ label : UILabel) {
        label.text = "Kategoriler"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        
        NSLayoutConstraint.activate( [ 
            label.widthAnchor.constraint(equalToConstant: 70),
            label.heightAnchor.constraint(equalToConstant: 17),
//            label.topAnchor.constraint(equalTo: homeView.searchBar.bottomAnchor, constant: 10)

        ])
    }
    
}





