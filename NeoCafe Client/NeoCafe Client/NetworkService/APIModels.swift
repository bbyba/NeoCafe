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
