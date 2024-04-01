//
//  Model.swift
//  NeoCafe Staff
//
//  Created by Burte Bayaraa on 2024.03.26.
//

import Foundation

// MARK: - OrderDetails
struct OrderDetailsModel: Codable {
    let id, orderNumber: Int
    let orderStatus, createdAt, updatedAt, completedAt: String
    let branch: Int
    let orderType, totalSum: String
    let customer: Int
    let bonusPoints: String
    let ito: [Ito]

    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case orderStatus = "order_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case completedAt = "completed_at"
        case branch
        case orderType = "order_type"
        case totalSum = "total_sum"
        case customer
        case bonusPoints = "bonus_points"
        case ito = "ITO"
    }
}

// MARK: - Ito
struct Ito: Codable {
    let id, item: Int
    let itemName: String
    let quantity: Int
    let totalPrice: String

    enum CodingKeys: String, CodingKey {
        case id, item
        case itemName = "item_name"
        case quantity
        case totalPrice = "total_price"
    }
}


// MARK: - Menu
struct AllMenuItems: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let description: String?
    let itemImage: String?
    let pricePerUnit: Int
    let branch: Int?
    let category: CategoryModel
    let ingredients: [Ingredient]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, branch, category, ingredients
        case itemImage = "item_image"
        case pricePerUnit = "price_per_unit"
    }
}

struct CategoryModel: Codable {
    let id: Int
    let name: String
    let image: String?
}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let quantity: Int
    let measurementUnit: String

    enum CodingKeys: String, CodingKey {
        case id, name, quantity
        case measurementUnit = "measurement_unit"
    }
}
