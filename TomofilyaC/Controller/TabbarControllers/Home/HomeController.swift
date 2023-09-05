//
//  HomeController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit


class HomeController: UIViewController, UISearchBarDelegate, UITextFieldDelegate , HomeViewDelegate ,UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
    private var homeModel = HomeModel()
    private lazy var homeView = HomeView()
    private var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        setupView()
        setupSearchBar()
        homeView.favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    private func setupView() {
        view = homeView
    }
    
    
    private func setupSearchBar() {
        homeView.searchBar.delegate = self
        if let textField = homeView.searchBar.value(forKey: "searchField") as? UITextField {
            textField.delegate = self
        }
    }
    
    // UISearchBarDelegate metodları buraya eklenebilir
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Arama metni değiştiğinde yapılacak işlemler
    }
    
    @objc func didTapFavoriteButton() {
        
        print("Butona Tıklandı.")
    }

}



