//
//  Models.swift
//  NeoCafe Staff
//

import Foundation

// MARK: - Auth

struct ConfirmationResponse: Codable {
    let message, waiterEmail, csrfToken: String

    enum CodingKeys: String, CodingKey {
        case message
        case waiterEmail = "waiter_email"
        case csrfToken = "csrf_token"
    }
}

struct AuthenticationResponse: Codable {
    let message, accessToken, refreshToken: String
    let branchID, userID: Int

    enum CodingKeys: String, CodingKey {
        case message
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case branchID = "branch_id"
        case userID = "user_id"
    }
}

// MARK: - Profile

struct ProfileResponse: Codable {
    let id: Int
    let user: User
    let userType: String
    let branch: Int?

    enum CodingKeys: String, CodingKey {
        case id, user
        case userType = "user_type"
        case branch
    }
}

struct User: Codable {
    let id: Int
    let username, password, firstName: String
    let lastName: Int?
    let email, userType: String
    let branch: Int
    let branchName: String
    let employeeSchedules: [EmployeeSchedule]

    enum CodingKeys: String, CodingKey {
        case id, username, password
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case userType = "user_type"
        case branch
        case branchName = "branch_name"
        case employeeSchedules = "employee_schedules"
    }
}

struct EmployeeSchedule: Codable {
    let day, startTime, endTime: String

    enum CodingKeys: String, CodingKey {
        case day
        case startTime = "start_time"
        case endTime = "end_time"
    }
}


// MARK: - Menu

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

struct Item: Codable {
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

struct Category: Codable {
    let id: Int
    let name: String
}

struct Ingredient: Codable {
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

// MARK: - Tables
struct TableModel: Codable {
    let id, tableNumber: Int
    let isAvailable: Bool
    let branch: Int

    enum CodingKeys: String, CodingKey {
        case id
        case tableNumber = "table_number"
        case isAvailable = "is_available"
        case branch
    }
}

