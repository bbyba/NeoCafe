//
//  APIModels.swift
//  NeoCafe Client
//

import Foundation

// MARK: - Authentication
struct CheckEmailModel: Codable {
    let email: String
}

struct AuthenticationModel: Codable {
    let email: String
    let confirmation_code: String
}

// MARK: - Main
struct AllMenuItems: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let description: String
    let itemImage: String
    let pricePerUnit: Int
    let branch: Int
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


// MARK: - Branches
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

//extension BranchModel {
//    var formattedSchedule: String {
//        return schedules.map { schedule in
//            let formattedStartTime = String(schedule.startTime.dropLast(3))
//            let formattedEndTime = String(schedule.endTime.dropLast(3))
//            return "\(schedule.day): \(formattedStartTime) - \(formattedEndTime)"
//        }.joined(separator: "\n")
//    }
//}

//extension BranchModel {
//    func todaysSchedule() -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "E" // Day of the week, format like "Mon", "Tue", etc.
//        dateFormatter.locale = Locale(identifier: "ru_RU") // Use Russian locale to match the day symbols
//        let todaySymbol = dateFormatter.string(from: Date())
//
//        if let todaySchedule = schedules.first(where: { $0.day == todaySymbol }) {
//            let formattedStartTime = String(todaySchedule.startTime.dropLast(3))
//            let formattedEndTime = String(todaySchedule.endTime.dropLast(3))
//            return "\(formattedStartTime) - \(formattedEndTime)"
//        } else {
//            return nil
//        }
//    }
//}

extension BranchModel {
    var todaySchedule: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E" // gives the day format like "Mon", "Tue"
        let todayShortString = dateFormatter.string(from: Date())

        if let todaySchedule = schedules.first(where: { $0.day == todayShortString }) {
            let formattedStartTime = String(todaySchedule.startTime.dropLast(3))
            let formattedEndTime = String(todaySchedule.endTime.dropLast(3))
            return "\(formattedStartTime) - \(formattedEndTime)"
        }
        return nil
    }
}





// MARK: - Temporary

struct NotificationModel {
    let status: String
    let details: String
    let time: String
}
