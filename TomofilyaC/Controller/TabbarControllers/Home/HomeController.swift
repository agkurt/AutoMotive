//
//  HomeController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit


class HomeController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
    
    private var homeModel = HomeModel()
    private lazy var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
    }
    
    private func setupView() {
        view = homeView
    }
    
    private func setupSearchBar() {
        homeView.searchBar.delegate = self
        // UISearchBar'ın UITextField bileşenini alıp delegate'ini ayarlıyoruz
        if let textField = homeView.searchBar.value(forKey: "searchField") as? UITextField {
            textField.delegate = self
        }
    }
    
    // UISearchBarDelegate metodları buraya eklenebilir
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Arama metni değiştiğinde yapılacak işlemler
    }
    
  
}



