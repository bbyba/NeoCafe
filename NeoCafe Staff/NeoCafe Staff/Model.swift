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
