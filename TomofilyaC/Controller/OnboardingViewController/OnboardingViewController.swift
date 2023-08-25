//
//  ViewController.swift
//  Tomofilya
//
//  Created by Ahmet Göktürk Kurt on 3.08.2023.
//


import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    var onboardingView: OnboardingView!
    
    let onboardingPages: [OnboardingPage] = [
        OnboardingPage(imageName: "porsche"),
        OnboardingPage(imageName: "Mustang"),
        OnboardingPage(imageName: "Gwagon")
    ]
    
    override func loadView() {
        onboardingView = OnboardingView(frame: UIScreen.main.bounds)
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        configureOnboarding()
        view.backgroundColor = UIColor.black
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        onboardingView.pageControl.currentPage = Int(pageIndex)
    }
    
    private func setupButtons() {
        onboardingView.registerLoginButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        onboardingView.startUsingButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == onboardingView.registerLoginButton {
            showOnboardingScreen()
        } else if sender == onboardingView.startUsingButton {
          
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onboardingView.registerLoginButton.isHighlighted = false
        onboardingView.startUsingButton.isHighlighted = false
    }
    
    private func configureOnboarding() {
        onboardingView.loadContent(pages: onboardingPages)
        onboardingView.scrollView.delegate = self
    }
    
    func showOnboardingScreen() {
        let loginScreenVC = LoginViewController()
        self.navigationController?.pushViewController(loginScreenVC, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
