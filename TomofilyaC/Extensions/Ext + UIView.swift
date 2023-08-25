//
//  Ext + UIView.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 9.08.2023.
//

import UIKit

extension UIView {
    // UIView için bir extension ile sadece belirli köşeleri yuvarlamak için bir yardımcı fonksiyon ekleyin
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                paddingTop: CGFloat = 0,
                paddingBottom: CGFloat = 0
    ){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterX).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
}
