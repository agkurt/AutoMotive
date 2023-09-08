//
//  homeAll.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 7.09.2023.
//

import UIKit

struct HomeResponse: Decodable {
    let data: HomeData
    let success: Bool
    let message: String
}

struct HomeData: Decodable {
    let categories: [Category]
    let garages: [Garage]
    let products: [Product]
    let tomopuan: Int
}

struct Category: Decodable {
    let id: Int
    let parentId: Int
    let name: String
    let parent: String
    let iconUrl: String
    let subCategories: [String?]
}

struct Garage: Decodable {
    let id: Int
    let logoUrl: String
    let userName: String
    let startDate: String
    let endDate: String
}

struct Product: Decodable {
    let id: Int
    let garageId: Int
    let campaignRate: Int
    let stock: Int
    let price: Int
    let brandName: String
    let title: String
    let photoUrl: String
    let approve: String
    let startDate: String
    let endDate: String
    let campaign: Campaign
}

struct Campaign: Decodable {
    let discountRate: Int
    let discountedPrice: Int
    let normalPrice: Int
}


// ... Diğer yapıları da benzer şekilde oluşturabilirsiniz ...

