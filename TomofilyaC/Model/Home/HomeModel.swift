//
//  HomeModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 4.09.2023.
//

import Foundation

struct HomeModel {
    var categories: [CategoryItem] = [
        CategoryItem(title: "Araç & Yedek Parça & Aksesuar", image: "part"),
        CategoryItem(title: "Jant & Lastik", image: "wheel"),
        CategoryItem(title: "Bakım & Onarım", image: "oil"),
        CategoryItem(title: "Garaj Ekipman & Alet", image: "alet"),
        CategoryItem(title: "Tomoclub & Market & Tekstil", image: "tshirt"),
        CategoryItem(title: "Ses & Görüntü Sistemleri", image: "music")
    ]
}
