//
//  CustomCollectionViewCell.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 5.09.2023.
//

import UIKit


class CustomCollectionViewCell : UICollectionViewCell {
    var buttons : [UIButton] = []
    
    override init (frame : CGRect) {
        super.init(frame: frame)
        setupButtons()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    private func setupButtons() {
        let buttonWidth = self.bounds.width / 3 // 3'e bölünmüş genişlik
        let buttonHeight = self.bounds.height / 3 // 3'e bölünmüş yükseklik
        
        for i in 0..<9 {
            let button = UIButton()
            button.frame = CGRect(
                x: buttonWidth * CGFloat(i % 3),
                y: buttonHeight * CGFloat(i / 3),
                width: buttonWidth,
                height: buttonHeight
            )
            // Buton özelliklerini ayarla
            // Örneğin: button.setTitle("Buton \(i+1)", for: .normal)
            addSubview(button)
            buttons.append(button)
        }
    }
}
