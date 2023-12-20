//
//  HomeController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController , HomeViewDelegate {
    
    private let homeModel = HomeModel()
    private let homeView = HomeView()
    private let searchBar = HomeView.createSearchBar()
    
    init() {
        super.init(collectionViewLayout: HomeCollectionViewController.createLayout())
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 5
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(82)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging

                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(108), heightDimension: .absolute(80)))
                item.contentInsets.trailing = 13
                item.contentInsets.bottom = 13
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                group.interItemSpacing = .flexible(13)
                

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
                ]
                section.interGroupSpacing = 13
                return section
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 32
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
                return section
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController()
        controller.view.backgroundColor = indexPath.section == 0 ? .yellow : .blue
        navigationController?.pushViewController(controller, animated: true)
    }
    
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeModel.categories.count
        }
        return homeModel.categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .blue
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! CategoryCollectionCell
            let categoryItem = homeModel.categories[indexPath.row]
            cell.backgroundColor = .black
            cell.configure(with: categoryItem)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .blue
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) // Or provide a different cell type here if needed
            cell.backgroundColor = .red // Or any other configuration you need for this section
            return cell
        default:
            fatalError("Unknown section: \(indexPath.section)")
        }
    }

    
        private let cellId = "cellId"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSearchBar()
            collectionView.backgroundColor = .black
            
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
            collectionView.register(Header.self, forSupplementaryViewOfKind: HomeCollectionViewController.categoryHeaderId, withReuseIdentifier: headerId)
            collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "categoryCollectionCell")
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupSearchBar() {
            view.addSubview(searchBar)
            
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
            ])
        }
        func didTapFavoriteButton() {
            print("favbutontapped")
        }
        
    }
    
    class Header: UICollectionReusableView {
        let label = UILabel()
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            label.text = "Kategoriler"
            
            addSubview(label)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
