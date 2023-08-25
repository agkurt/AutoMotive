//
//  Ext + NsLayoutConstraints.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.08.2023.
//

import UIKit

extension NSLayoutConstraint {
    func butonConstraint(_ button  : UIButton , width :CGFloat , height : CGFloat , centerX :  NSLayoutXAxisAnchor , topAnchor :  NSLayoutAnchor<AnyObject>  , constant : CGFloat) {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height),
            button.centerXAnchor.constraint(equalTo: centerX),
            button.topAnchor.constraint(equalTo:topAnchor , constant:constant )
        ])
       
    }
}
