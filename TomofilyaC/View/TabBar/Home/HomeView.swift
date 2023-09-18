//
//  HomeView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 4.09.2023.
//

import UIKit

protocol HomeViewDelegate : AnyObject {
    func didTapFavoriteButton()
}

class HomeView: UIView {
    
    let tomofilyaImage = UIImageView()
    let favoriteButton = UIButton()
    let searchBar = createSearchBar()
    private let categoryLabel = UILabel()
    
        let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private static func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        
        configureSearchBarAppearance(searchBar)
        configureSearchBarTextField(searchBar)
        configureSearchBarImages(searchBar)
        
        return searchBar
    }
    
    private static func configureSearchBarAppearance(_ searchBar: UISearchBar) {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 20
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.red.cgColor
        searchBar.placeholder = "Ürün / Kategori / Marka / Garaj ara"
        searchBar.clipsToBounds = true
    }
    
    private static func configureSearchBarTextField(_ searchBar: UISearchBar) {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.black
            textField.textColor = UIColor.white
            textField.leftViewMode = .never
        }
    }
    
    private static func configureSearchBarImages(_ searchBar: UISearchBar) {
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.showsSearchResultsButton = true
        searchBar.setImage(UIImage(named: "searchImage"), for: .resultsList, state: .normal)
    }
    
    private func setupView() {
        setupSearchBar()
        setupImageView()
        configureButton(favoriteButton)
        setupCollectionView()
        configureLabel(categoryLabel)
    }
    
    
    private func setupSearchBar() {
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 68),
            searchBar.widthAnchor.constraint(equalToConstant: 350),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupImageView() {
        configureImage(tomofilyaImage)
    }
    
    private func configureImage(_ image: UIImageView) {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "tomofilyaImage")
        addSubview(image)
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 45.31),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 44)
        ])
    }
    
    private func configureButton(_ button : UIButton) {
        let favoriteImage = UIImage(named: "favoriteIcon")
        button.setImage(favoriteImage, for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.centerYAnchor.constraint(equalTo: tomofilyaImage.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: tomofilyaImage.trailingAnchor, constant: 156)
        ])
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    private func configureLabel(_ label : UILabel) {
        label.text = "Kategoriler"
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
    
        NSLayoutConstraint.activate( [
            label.widthAnchor.constraint(equalToConstant: 70),
            label.heightAnchor.constraint(equalToConstant: 17),
        ])
    }
}


