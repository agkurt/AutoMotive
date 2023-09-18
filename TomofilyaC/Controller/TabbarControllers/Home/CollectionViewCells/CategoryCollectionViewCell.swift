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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        for _ in 0..<6 { // viewler oluşturuldu.
            let sectionView = UIView()
            sectionView.translatesAutoresizingMaskIntoConstraints = false
            sectionView.backgroundColor = .black
            sectionView.layer.borderColor = UIColor.white.cgColor
            sectionView.layer.borderWidth = 0.5
            sectionView.layer.cornerRadius = 20
            contentView.addSubview(sectionView)
            sections.append(sectionView)
            
        }
        
        for i in 0..<3 { // üst 3 view için for döngüsü yazıldı.
            NSLayoutConstraint.activate([
                sections[i].topAnchor.constraint(equalTo: contentView.topAnchor),
                sections[i].leadingAnchor.constraint(equalTo: i == 0 ? contentView.leadingAnchor : sections[i-1].trailingAnchor, constant: 13),
                sections[i].widthAnchor.constraint(equalToConstant: 108),
                sections[i].heightAnchor.constraint(equalToConstant: 80),
            ])
        }
        
        for i in 3..<6 { // alt 3 view için for döngüsü yazıldı.
            NSLayoutConstraint.activate([
                sections[i].topAnchor.constraint(equalTo: sections[0].bottomAnchor, constant: 13),
                sections[i].leadingAnchor.constraint(equalTo: i == 3 ? contentView.leadingAnchor : sections[i-1].trailingAnchor, constant: 13),
                sections[i].widthAnchor.constraint(equalToConstant: 108),
                sections[i].heightAnchor.constraint(equalToConstant: 80)
            ])
        }
    }
    
    func configureCell(with categories: [CategoryItem]) { // CategoryItem içerisinden title ve image'leri çekebilmek için for döngüsü kullanıldı.
        for (index, category) in categories.enumerated() {
            let label = UILabel()
            label.text = category.title // category içerisindeki titlelar çekildi.
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.numberOfLines = 1
            label.font = UIFont(name: "Poppins-Regular", size: 8)
        
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: category.image) // category içerisindeki imageler çekildi.
            imageView.contentMode = .scaleAspectFit
            
            let section = sections[index]
            
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
    
}





