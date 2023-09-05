//
//  TabBarController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 28.08.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.setupTabs()
        self.tabBar.barTintColor = .red
        self.tabBar.tintColor = .orange
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.layer.borderColor = UIColor.white.cgColor
        self.tabBar.layer.borderWidth = 1.0
        self.tabBar.layer.cornerRadius = 25
    }
    private func setupTabs() {
        
        let home = self.createNav(with: "Ana Sayfa", and: UIImage(named: "Home"), vc: HomeController())
        let message = self.createNav(with: "Mesajlar", and: UIImage(named: "Message"), vc: MessageController())
        let garage = self.createNav(with: "Garajım", and: UIImage(named: "barLogo"), vc: GarageController())
        let shop = self.createNav(with: "Sepetim", and: UIImage(named: "Shopping"), vc: ShopController())
        let profile = self.createNav(with: "Profil", and: UIImage(named: "Profile"), vc: ProfileController())
        self.setViewControllers([home , message , garage , shop , profile], animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabFrame = self.tabBar.frame
        let tabHeight: CGFloat = 110
        let tabWidth: CGFloat = 395
        tabFrame.size.height = tabHeight
        tabFrame.size.width = tabWidth
        tabFrame.origin.y = (self.view.frame.size.height - tabHeight) + 5
        tabFrame.origin.x = (self.view.frame.size.width - tabWidth) / 2
        self.tabBar.frame = tabFrame
    }
    
    
    private func createNav(with title : String  ,and image : UIImage? , vc :UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        if let font = UIFont(name: "Poppins-Regular", size: 8) {
            nav.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
        }
        
        return nav
    }
    
    
}
