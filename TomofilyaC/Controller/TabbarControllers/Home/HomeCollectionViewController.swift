//
//  HomeController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit

class HomeCollectionViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate, HomeViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private var homeModel = HomeModel()
    private lazy var homeView = HomeView()
    private var garageView = fastGarageView()
    private var collectionView: UICollectionView?
    private var imageView = UIImageView()
    private var homeData: HomeData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.black
        
        transparentBackGround()
        view = homeView
        setupSearchBar()
        homeView.favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    private func setupSearchBar() {
        homeView.searchBar.delegate = self
        if let textField = homeView.searchBar.value(forKey: "searchField") as? UITextField {
            textField.delegate = self
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    @objc func didTapFavoriteButton() {
        print("Butona Tıklandı.")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int ) -> Int {
       return 15
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
            return cell
    }
    private let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0 :
            return CGSize(width: view.bounds.width, height: 173)
        case 1 :
            return CGSize(width: view.bounds.width, height: 104)
        default :
            return CGSize(width: view.bounds.width, height: view.bounds.height)
        }
    }
    
    private func transparentBackGround() {
        let headerHeight: CGFloat = 160
        collectionView?.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        let transparentBackground = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight))
        transparentBackground.backgroundColor = .black
        transparentBackground.alpha = 0.5
        
        homeView.insertSubview(transparentBackground, at: 0)
        homeView.addSubview(collectionView!)
        homeView.addSubview(homeView.tomofilyaImage)
        homeView.addSubview(homeView.searchBar)
        homeView.addSubview(homeView.favoriteButton)
        
        homeView.searchBar.layer.zPosition = 1
        homeView.favoriteButton.layer.zPosition = 1
        homeView.tomofilyaImage.layer.zPosition = 1
    }
    
}

