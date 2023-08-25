//
//  FirstSplashScreenController.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 6.08.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    var firstSplashScreenView: SplashScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSplashScreenView = SplashScreenView(frame: view.frame)
        view = firstSplashScreenView
        firstSplashScreenView.backgroundColor = UIColor.black
        firstSplashScreenView.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let targetCenter = CGPoint(x: view.center.x, y: view.center.y - 100)
        let targetTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.firstSplashScreenView.imageView.center = targetCenter
            self.firstSplashScreenView.imageView.transform = targetTransform
        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.firstSplashScreenView.imageLabel.alpha = 1.0
            }) { _ in
                self.showOnboardingScreen()
            }
        }
    }

    
    func showOnboardingScreen() {
        let loginScreenVC = OnboardingViewController()
        let navController = UINavigationController(rootViewController: loginScreenVC)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(navController, animated: true, completion: nil)
        }
    }
}
