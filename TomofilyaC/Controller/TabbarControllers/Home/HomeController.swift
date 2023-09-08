//
//  HomeController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit

class HomeController: UIViewController, UISearchBarDelegate, UITextFieldDelegate, HomeViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private var homeModel = HomeModel()
    private lazy var homeView = HomeView()
    private var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        fetchHomeData()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.black
        transparentBackGround()
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    @objc func didTapFavoriteButton() {
        print("Butona Tıklandı.")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cell = homeModel.categories.count
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = homeModel.categories[indexPath.row]
            cell.configureCell(with: homeModel.categories)
            cell.backgroundColor = .black
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 390 , height: 173)
        }else {
            return CGSize(width: view.bounds.width, height: 173)
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
    
    func fetchHomeData() {
        AuthService.shared.fetchHomeData { (success, homeResponse, errorMessage) in
            DispatchQueue.main.async {
                if success, let homeResponse = homeResponse {
                    // Veriyi kullan
                } else {
                    // Hata mesajını göster
                    print(errorMessage ?? "Unknown error")
                }
            }
        }
    }


}
    
