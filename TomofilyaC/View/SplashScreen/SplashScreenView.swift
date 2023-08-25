//
//  FirstSplashScreenView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 8.08.2023.
//

// FirstSplashScreenView.swift
import UIKit

class SplashScreenView: UIView {
    let imageView = UIImageView()
    let imageLabel = UILabel()

    func setupUI() {
        imageView.image = UIImage(named: "Tomofilya")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.transform = CGAffineTransform.identity

        imageLabel.text = "Selam 👋\nTomofilya’ya Hoş Geldin!"
        imageLabel.numberOfLines = 2
        imageLabel.textAlignment = .center
        imageLabel.textColor = UIColor.white
        imageLabel.font = UIFont.systemFont(ofSize: 20)
        imageLabel.alpha = 0 // İlk başta metni görünmez yap
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageLabel)

        imageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -80.48).isActive = true
    }
}
