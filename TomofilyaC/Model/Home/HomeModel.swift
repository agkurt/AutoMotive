//
//  HomeModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 4.09.2023.
//

import UIKit

class HomeModel {
    var categories: [Categories] = [
        Categories(title: "Araç & Yedek Parça & Aksesuar", image: "part"),
        Categories(title: "Jant & Lastik", image: "wheel"),
        Categories(title: "Bakım & Onarım", image: "oil"),
        Categories(title: "Garaj Ekipman & Alet", image: "alet"),
        Categories(title: "Tomoclub & Market & Tekstil", image: "tshirt"),
        Categories(title: "Ses & Görüntü Sistemleri", image: "music")
    ]
}
