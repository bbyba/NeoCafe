//
//  Models.swift
//  NeoCafe Staff
//

import Foundation

//Auth

struct Credentials: Codable {
    let username, password: String
}

struct EmailConfirmation: Codable {
    let email, confirmationCode: String

    enum CodingKeys: String, CodingKey {
        case email
        case confirmationCode = "confirmation_code"
    }
}

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
