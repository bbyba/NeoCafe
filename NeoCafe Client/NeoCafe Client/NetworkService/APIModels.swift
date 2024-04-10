//
//  APIModels.swift
//  NeoCafe Client
//

import Foundation

// MARK: - Authentication
struct MessageResponse: Codable {
    let message: String
}

struct CheckEmailModel: Codable {
    let email: String
}

struct AuthenticationModel: Codable {
    let email: String
    let confirmation_code: String
}

struct AuthResponseModel: Codable {
    let message, accessToken, refreshToken: String
    let customerProfile: CustomerProfile?

    enum CodingKeys: String, CodingKey {
        case message
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case customerProfile = "customer_profile"
    }
}

// MARK: - Main
struct AllMenuItems: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: Results
}

struct Results: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Item]
}

struct Item: Codable, Hashable {
    let id: Int
    let name, description: String
    let itemImage: String?
    let pricePerUnit: Int
    let branch: Int?
    let category: Category
    let ingredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case itemImage = "item_image"
        case pricePerUnit = "price_per_unit"
        case branch, category, ingredients
    }
}

struct Category: Codable, Hashable  {
    let id: Int
    let name: String
}

struct Ingredient: Codable, Hashable {
    let id: Int
    let name: String
    let quantity: Int
    let measurementUnit: MeasurementUnit

    enum CodingKeys: String, CodingKey {
        case id, name, quantity
        case measurementUnit = "measurement_unit"
    }
}

enum MeasurementUnit: String, Codable {
    case гр = "гр"
    case мл = "мл"
    case шт = "шт"
}

struct CategoryModel: Codable {
    let id: Int
    let name: String
    let image: String?
}


// MARK: - Branches

struct BranchesResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [BranchModel]
}

struct BranchModel: Codable {
    let id: Int
    let branchName, address, phoneNumber: String
    let link2gis: String
    let tableQuantity: Int
    let image: String?
    let description: String
    let schedules: [Schedule]

    enum CodingKeys: String, CodingKey {
        case id
        case branchName = "branch_name"
        case address
        case phoneNumber = "phone_number"
        case link2gis = "link_2gis"
        case tableQuantity = "table_quantity"
        case image, description, schedules
    }
}

struct Schedule: Codable {
    let day, startTime, endTime: String

    enum CodingKeys: String, CodingKey {
        case day
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

extension BranchModel {
    var todaySchedule: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E"
        let todayShortString = dateFormatter.string(from: Date())

        if let todaySchedule = schedules.first(where: { $0.day == todayShortString }) {
            let formattedStartTime = String(todaySchedule.startTime)
            let formattedEndTime = String(todaySchedule.endTime)
            return "\(formattedStartTime) - \(formattedEndTime)"
        }
        return nil
    }
}



// MARK: - Profile
struct CustomerProfile: Codable {
    let id: Int
    let userID: Int
    let firstName: String
    let email: String
    let bonusPoints: Int
//    let orders: [Order]?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case firstName = "first_name"
        case bonusPoints = "bonus_points"
        case id, email
    }
}

// MARK: - Order
struct Order: Codable {
    let id, totalPrice: Int
    let table: Table
    let status, createdAt: String
    let customer: Int
    let updatedAt, completedAt: String
    let branch: Int
    let orderType, totalSum: String
    let employee: Int
    let ito: [Ito]

    enum CodingKeys: String, CodingKey {
        case id
        case totalPrice = "total_price"
        case table, status
        case createdAt = "created_at"
        case customer
        case updatedAt = "updated_at"
        case completedAt = "completed_at"
        case branch
        case orderType = "order_type"
        case totalSum = "total_sum"
        case employee
        case ito = "ITO"
    }
}

// MARK: - Ito
struct Ito: Codable {
    let id, item: Int
    let itemName: String
    let quantity: Int
    let totalPrice: Int

    enum CodingKeys: String, CodingKey {
        case id, item
        case itemName = "item_name"
        case quantity
        case totalPrice = "total_price"
    }
}

// MARK: - Table
struct Table: Codable {
    let tableNumber: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case tableNumber = "table_number"
        case status
    }
}

// MARK: - Temporary

struct NotificationModel {
    let status: String
    let details: String
    let time: String
}
