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
struct CategoryModel: Codable {
    let id: Int
    let name: String
    let image: String?
}
