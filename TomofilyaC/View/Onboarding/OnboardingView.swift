//
//  OnboardingView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 8.08.2023.
//

import UIKit

class OnboardingView: UIView {
    let registerLoginButton = UIButton()
    let startUsingButton = UIButton()
    var imageView = UIImageView()
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getTitleImage()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func setupUI() {
        // Register / Login Button
        registerLoginButton.translatesAutoresizingMaskIntoConstraints = false
        registerLoginButton.setTitle("Kayıt Ol / Giriş Yap", for: .normal)
        registerLoginButton.backgroundColor = UIColor.white
        registerLoginButton.setTitleColor(UIColor.black, for: .normal)
        registerLoginButton.layer.cornerRadius = 20
        addSubview(registerLoginButton)
        
        // Constraints for Register / Login Button
        NSLayoutConstraint.activate([
            registerLoginButton.widthAnchor.constraint(equalToConstant: 304),
            registerLoginButton.heightAnchor.constraint(equalToConstant: 40),
            registerLoginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            registerLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        
        // Start Using Button
        startUsingButton.translatesAutoresizingMaskIntoConstraints = false
        startUsingButton.setTitle("Kullanmaya Başla", for: .normal)
        startUsingButton.backgroundColor = UIColor.clear
        startUsingButton.setTitleColor(UIColor.white, for: .normal)
        addSubview(startUsingButton)
        
        // Constraints for Start Using Button
        NSLayoutConstraint.activate([
            startUsingButton.widthAnchor.constraint(equalToConstant: 140),
            startUsingButton.heightAnchor.constraint(equalToConstant: 17),
            startUsingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startUsingButton.topAnchor.constraint(equalTo: registerLoginButton.bottomAnchor, constant: 16)
        ])
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        addSubview(pageControl)
        
        // page control kısıtlamaları
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: registerLoginButton.topAnchor, constant: -64), // 64 piksel boşluk
            pageControl.widthAnchor.constraint(equalToConstant: 60),
            pageControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        addSubview(scrollView)
        
        // scrollView kısıtlamaları
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20), // imageView'dan sonraki 20 piksel boşluk
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20) // pageControl'den önceki 20 piksel boşluk
        ])
        
    }
    
    func getTitleImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Tomofilya")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func loadContent(pages: [OnboardingPage]) {
        pageControl.numberOfPages = pages.count
        scrollView.isDirectionalLockEnabled = true
        
        var previousImageView: UIImageView?
        
        for page in pages {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            if let imageName = page.imageName {
                imageView.image = UIImage(named: imageName)
            }
            scrollView.addSubview(imageView)
            
            var leadingConstraint: NSLayoutConstraint
            if let previousView = previousImageView {
                leadingConstraint = imageView.leadingAnchor.constraint(equalTo: previousView.trailingAnchor)
            } else {
                leadingConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            }
            
        
            let topConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
            let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
            let widthConstraint = imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            let heightConstraint = imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            
            NSLayoutConstraint.activate([
                leadingConstraint,
                topConstraint,
                bottomConstraint,
                widthConstraint,
                heightConstraint
            ])
            
            previousImageView = imageView
        }
        
        if let lastImageView = previousImageView {
            lastImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        }
    }
    
}
