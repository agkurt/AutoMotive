//
//  HomeView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 4.09.2023.
//

import UIKit

class HomeView: UIView {
    
    let imageView = UIImageView()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 20
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.red.cgColor
        searchBar.placeholder = "Ürün / Kategori / Marka / Garaj ara"
        searchBar.clipsToBounds = true
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
            textField.leftViewMode = .never
        }
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.showsSearchResultsButton = true
        searchBar.setImage(UIImage(named: "searchImage"), for: .resultsList, state: .normal)
        
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureImage()
        addSubview(searchBar)
        
        // Constraints (kısıtlamalar) ayarlanıyor
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 112),
            searchBar.widthAnchor.constraint(equalToConstant: 350),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureImage() {
        imageView.image = UIImage(named: "Tomofilya")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 45.31),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])

    }
}

