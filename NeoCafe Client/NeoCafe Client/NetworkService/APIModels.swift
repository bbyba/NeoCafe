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
//
//struct BranchModel: Codable {
//    let id: Int
//    let branchName: String
//    let address: String
//    let phone_number: String
//    let link_2gis: String
//    let table_quantity: Int
//    let image: String?
//    let description: String
//    let schedules: [Schedule]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case branchName = "branch_name"
//        case address
//        case phoneNumber = "phone_number"
//        case link2gis = "link_2gis"
//        case tableQuantity = "table_quantity"
//        case image
//        case description
//        case schedules
//    }
//}
//
//
//struct Schedule: Codable {
//    let day: String
//    let startTime: String
//    let endTime: String
//
//    enum CodingKeys: String, CodingKey {
//        case day
//        case startTime = "start_time"
//        case endTime = "end_time"
//    }
//}
//
////
////struct BranchModel: Codable {
////    let id : Int?
////    let branchName : String
////    let address : String?
////    let phone_number : String?
////    let link_2gis : String?
////    let table_quantity : Int?
////    let image : String?
////    let description : String?
////    let schedules : [Schedules]?
////
////    enum CodingKeys: String, CodingKey {
////
////        case id = "id"
////        case branchName = "branch_name"
////        case address = "address"
////        case phoneNumber = "phone_number"
////        case link_2gis = "link_2gis"
////        case table_quantity = "table_quantity"
////        case image = "image"
////        case description = "description"
////        case schedules = "schedules"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        id = try values.decodeIfPresent(Int.self, forKey: .id)
////        branchName = try values.decode(String.self, forKey: .branchName)
////        address = try values.decodeIfPresent(String.self, forKey: .address)
////        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
////        link_2gis = try values.decodeIfPresent(String.self, forKey: .link_2gis)
////        table_quantity = try values.decodeIfPresent(Int.self, forKey: .table_quantity)
////        image = try values.decodeIfPresent(String.self, forKey: .image)
////        description = try values.decodeIfPresent(String.self, forKey: .description)
////        schedules = try values.decodeIfPresent([Schedules].self, forKey: .schedules)
////    }
////
////}
////
////struct Schedules : Codable {
////    let day : String?
////    let start_time : String?
////    let end_time : String?
////
////    enum CodingKeys: String, CodingKey {
////
////        case day = "day"
////        case start_time = "start_time"
////        case end_time = "end_time"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        day = try values.decodeIfPresent(String.self, forKey: .day)
////        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
////        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
////    }
////
////}



// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let branchName, address, phoneNumber: String
    let link2GIS: String
    let tableQuantity: Int
    let image: JSONNull?
    let description: String
    let schedules: [Schedule]

    enum CodingKeys: String, CodingKey {
        case id
        case branchName = "branch_name"
        case address
        case phoneNumber = "phone_number"
        case link2GIS = "link_2gis"
        case tableQuantity = "table_quantity"
        case image, description, schedules
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let day, startTime, endTime: String

    enum CodingKeys: String, CodingKey {
        case day
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

typealias Welcome = [WelcomeElement]

// MARK: - Encode/decode helpers
