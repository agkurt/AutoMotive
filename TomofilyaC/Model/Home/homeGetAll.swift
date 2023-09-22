//
//  homeAll.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 7.09.2023.
//

import Foundation // eğer UI işlemi yapmıyosan foundation kalsın.



struct HomeData: Decodable {
    let categories: [Category]?
    let garages: [Garage]?
    let products: [Product]?
}

struct Category: Decodable {
    let id: Int
    let parentId: Int
    let name: String
    let parent: String
    let iconUrl: String
    let subCategories: [String?]
}

struct Garage: Decodable { // for fast garages
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

struct UrgentProduct: Decodable {
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


struct PopularSearch: Decodable {
    let id: Int
    let title: String
}

struct LastAnnouncement: Decodable {
    let id: Int
    let name: String
    let photoUrl: String
    let description: String
    let isPublished: Bool
    let buttonUrl: String
    let date: String
    let clickUrlCount: Int
    let showPopupCount: Int
    let showPopup: Bool
    let hasButton: Bool
    let buttonName: String
}

struct LastEvent: Decodable {
    let id: Int
    let name: String
    let photoUrl: String
    let description: String
    let date: String
    let startDate: String
    let endDate: String
    let isPublished: Bool
    let showPopup: Bool
    let hasButton: Bool
    let buttonName: String
    let buttonUrl: String
    let lat: Double
    let lng: Double
}

struct LastVideo: Decodable {
    let videoUrl: String
    let title: String
    let date: String
    let isPublished: Bool
    let showPopup: Bool
    let clickUrlCount: Int
    let showPopupCount: Int
    let id: Int
}

struct RandomGlossary: Decodable {
    let id: Int
    let name: String
    let photoUrl: String
    let description: String
    let date: String
}

struct UserGarage: Decodable {
    let productCount: Int
    let rejectedProductCount: Int
    let champaignsCount: Int
    let orders: Int
    let soldProducts: Int
    let garageEarnings: Int
    let progressPayment: Int
    let remainingDay: Int
    let isUpdated: Bool
    let offerNumber: Int
    let commissionRate: Int
    let unUploadedDocuments: [String]
    let garageApprovalStatus: String
    let garageDetail: UserGarageDetail
}

struct UserGarageDetail: Decodable {
    let id: Int
    let score: Int
    let followerCount: Int
    let userName: String
    let logoUrl: String
    let bannerUrl: String
    let garageType: String
}

struct GarageInfo: Decodable {
    let garageId: Int
    let garageType: String
}

